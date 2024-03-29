#include "ArrowDownCreate.mqh"
#include "ArrowUpCreate.mqh"
#include "Buy.mqh"
#include "Fibo.mqh"
#include "FiboFanCreate.mqh"
#include "FridayMonday.mqh"
#include "Impulses.mqh"
#include "LineCreate.mqh"
#include "Mashenka.mqh"
#include "Random.mqh"
#include "RectangleCreate.mqh"
#include "SearchExtremum.mqh"
#include "Sell.mqh"
#include "StopProfit.mqh"
#include "TextCreate.mqh"
#include "TrendByAngleCreate.mqh"
#include "VallarMarginis.mqh"
#include "Variables.mqh"

void Buy() {
   priceBuy = Ask;
   numberOrderBuy = OrderSend (Symbol(),OP_BUY,LOTS,priceBuy,0,0,0,NULL,0,0,clrGreenYellow);
   profitUp = false;
   profit = NULL;
   ArrowUpCreate(TimeCurrent(),Ask,"Ордер покупки " + TimeToStr(TimeCurrent()),0,0,1,clrAqua);
}

void BuyClose () {
for (int i = 0;OrdersTotal()>0 && OrderSelect(i,SELECT_BY_POS)==true;i++) {// && OrderSelect(i,SELECT_BY_POS)==true
   orderBuyClose = OrderClose (OrderTicket(),LOTS,Bid,0,clrBlue);
   }
   profit = NULL;
   profitUp = false;
   OrderBuyMustHave = false;
   numberOrderBuy = NULL;
   OrderBuyNow = NULL;
   profitNow = NULL;
}

void Sell() {
   priceSell = Bid;
   numberOrderSell = OrderSend (Symbol(),OP_SELL,LOTS,priceSell,0,0,0,NULL,0,0,clrRed);
   profitUp = false;
   profit = NULL;
   ArrowDownCreate(TimeCurrent(),Bid,"Ордер продажи " + TimeToStr(TimeCurrent()),0,0,1,clrPink);
}

void SellClose () {
for (int i = 0;OrdersTotal()>0 && OrderSelect(i,SELECT_BY_POS)==true;i++) {// && OrderSelect(i,SELECT_BY_POS)==true
   orderSellClose = OrderClose (OrderTicket(),LOTS,Ask,0,clrOrange);
   }
   profit = NULL;
   profitUp = false;
   OrderBuyMustHave = false;
   numberOrderSell = NULL;   
   OrderBuyNow = NULL;
   profitNow = NULL;
}



 void OrdersTrendLine() {
   if (!FirstStartProgram && BuySell && HighPriceNew < HighPricePost && trend && HighPricePost && !numberOrderBuy && trendPrice < ObjectGetValueByTime(0,"TrendCanal "+HighPriceNew+" "+TimeToStr(HighPriceNewTime),trendTime)) {// 
      BUY = true; 
   }  
   else { BUY = false; }
   if (BUY && Ask > (ObjectGetValueByTime(0,"TrendCanal "+HighPriceNew+" "+TimeToStr(HighPriceNewTime),TimeCurrent()) + ObjectGetValueByTime(0,"TrendCanal "+HighPriceNew+" "+TimeToStr(HighPriceNewTime),TimeCurrent())/100*0.5)) {// 
      SellClose();
      orderSellClose = OrderClose (numberOrderSell,LOTS,Ask,0,clrOrange);
      Buy();
      BUY = false;
      BuySell = false;
   }
   if (!FirstStartProgram && BuySell && LowPriceNew > LowPricePost && !trend && LowPricePost && !numberOrderSell && trendPrice > ObjectGetValueByTime(0,"TrendCanal "+LowPriceNew+" "+TimeToStr(LowPriceNewTime),trendTime)) {// 
      SELL = true;
   }
   else { SELL = false; }
   if (SELL && Bid < (ObjectGetValueByTime(0,"TrendCanal "+LowPriceNew+" "+TimeToStr(LowPriceNewTime),TimeCurrent()) - ObjectGetValueByTime(0,"TrendCanal "+LowPriceNew+" "+TimeToStr(LowPriceNewTime),TimeCurrent())/100*0.5)) {// 
      BuyClose();
      orderBuyClose = OrderClose (numberOrderBuy,LOTS,Bid,0,clrBlue);
      Sell();
      SELL = false;
      BuySell = false;
   }
   
   //if (profitNow <= SL && numberOrderSell != NULL) {
   //   SellClose();
   //}
   //if (profitNow <= SL && numberOrderBuy != NULL) {
   //   BuyClose();
   //}
   
   if (profit > LOTS*10*60 && numberOrderSell != NULL) {
      if (profitNow == LOTS*10*100) {
         SellClose();
      }
      if (profitNow <= profit/100*50) {
         SellClose();
      }
   }
   
   if (profit > LOTS*10*60 && numberOrderBuy != NULL) {
      if (profitNow == LOTS*10*100) {
         BuyClose();
      }
      if (profitNow <= profit/100*50) {
         BuyClose();
      }
   }

   //if (!trend && numberOrderBuy != NULL && OrdersTotal()>0) {
   //   orderBuyClose = OrderClose (numberOrderBuy,LOTS,Bid,0,clrBlue);
   //   numberOrderBuy = NULL;
   //   profit = NULL;
   //}
   //if (trend && numberOrderSell != NULL && OrdersTotal()>0) {
   //   orderSellClose = OrderClose (numberOrderSell,LOTS,Ask,0,clrOrange);
   //   numberOrderSell = NULL;
   //   profit = NULL;
   //}
   if (OrderSelect(numberOrderBuy,SELECT_BY_TICKET)==true && numberOrderBuy!=0 && OrdersTotal()>0) {
   profitNow = OrderProfit();
      if (OrderProfit()>profit) {
         profit = OrderProfit();
      }
   }
   if (OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true && numberOrderSell!=0 && OrdersTotal()>0) {
   profitNow = OrderProfit();
      if (OrderProfit()>profit) {
         profit = OrderProfit();
      }
   }
}
 
 
 
 
 
 
 
 
 
 
void Orders() {
   if (!trend && numberOrderBuy != NULL && OrdersTotal()>0) {
      orderBuyClose = OrderClose (numberOrderBuy,LOTS,Bid,0,clrBlue);
      numberOrderBuy = NULL;
      profit = NULL;
      }
   if (trend && numberOrderSell != NULL && OrdersTotal()>0) {
      orderSellClose = OrderClose (numberOrderSell,LOTS,Ask,0,clrOrange);
      numberOrderSell = NULL;
      profit = NULL;
      }
   if (!trend && OrderBuyMustHave == true && impulseUrovDown12!=NULL && numberOrderSell == NULL && OrdersTotal()==0) {// && Bid < impulseUrovDown12
      Sell();
      //Print (numberOrderSell + " numberOrderSell");
      }
   if (OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true && numberOrderSell!=0 && OrdersTotal()>0 && OrderBuyNow == NULL && !trend && OrderBuyMustHave) {
         profitNow = OrderProfit();
         if(!profitUp && OrderProfit()<= SL){
         SellClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit() >= TRISK) {
         //Print("ОРДЕР ПРОДАЖИ ЗАРАБОТАЛ >= " + TRISK + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         //Print (OrderProfit() + " > " + profit);
         profit = OrderProfit();
         //Print ("Новый профит = " + profit);
         //Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if ((profit>=TRISK && profit<TRISK*1.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK1))) || 
      (profit>=TRISK*1.5 && profit<TRISK*2 && profitUp && OrderProfit()<(profit-(profit/100*RISK2))) || 
      (profit>=TRISK*2 && profit<TRISK*2.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK3))) || 
      (profit>=TRISK*2.5 && profit<TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK4))) || 
      (profit>=TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK5)))) { 
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         SellClose();
      }  
   }
   
//////////////////////////////////////////////////
   
   if (!trend && OrderBuyNow == 1 && numberOrderSell == NULL && OrdersTotal()==0) {
      Sell();
      //Print (numberOrderSell + " numberOrderSell");
      OrderBuyNow = 2;
      }
   if (OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true && numberOrderSell!=0 && OrdersTotal()>0 && OrderBuyNow != NULL && !trend) {
         profitNow = OrderProfit();
         if(OrderProfit()<= SL){
         SellClose();
         profit = NULL;
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit() >= TRISK) {
         //Print("ОРДЕР ПРОДАЖИ ЗАРАБОТАЛ >= " + TRISK + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         //Print (OrderProfit() + " > " + profit);
         profit = OrderProfit();
         //Print ("Новый профит = " + profit);
         //Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if ((profit>=TRISK && profit<TRISK*1.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK1))) || 
      (profit>=TRISK*1.5 && profit<TRISK*2 && profitUp && OrderProfit()<(profit-(profit/100*RISK2))) || 
      (profit>=TRISK*2 && profit<TRISK*2.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK3))) || 
      (profit>=TRISK*2.5 && profit<TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK4))) || 
      (profit>=TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK5)))) { 
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         SellClose();
      }  
    }      
 //////////////////////////////////////////////////  
   
      if (trend && OrderBuyMustHave == true && impulseUrovUp12!=NULL && numberOrderBuy == NULL && OrdersTotal()==0 && OrderBuyNow == NULL) {// && Ask > impulseUrovUp12
      Buy();
      //Print (numberOrderBuy + " numberOrderBuy");
      }
   if (OrderSelect(numberOrderBuy,SELECT_BY_TICKET)==true && numberOrderBuy!=0 && OrdersTotal()>0 && trend && OrderBuyMustHave) {
         profitNow = OrderProfit();
         if(!profitUp && OrderProfit()<= SL){
         BuyClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit()>= TRISK) {
         //Print("ОРДЕР ПОКУПКИ ЗАРАБОТАЛ >= " + TRISK + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         profit = OrderProfit();
         //Print ("Новый профит = " + profit);
         //Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if ((profit>=TRISK && profit<TRISK*1.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK1))) || 
      (profit>=TRISK*1.5 && profit<TRISK*2 && profitUp && OrderProfit()<(profit-(profit/100*RISK2))) || 
      (profit>=TRISK*2 && profit<TRISK*2.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK3))) || 
      (profit>=TRISK*2.5 && profit<TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK4))) || 
      (profit>=TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK5)))) { 
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         BuyClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
      }      
   }
   
//////////////////////////////////////////////////
   
   if (trend && OrderBuyNow == true && numberOrderBuy == NULL && OrdersTotal()==0) {
      Buy();
      Print (numberOrderBuy + " numberOrderBuy");
      OrderBuyNow = 2;
      }
   if (OrderSelect(numberOrderBuy,SELECT_BY_TICKET)==true && numberOrderBuy!=0 && OrdersTotal()>0 && OrderBuyNow != NULL && trend) {
         profitNow = OrderProfit();
         if(OrderProfit()<= SL){
         BuyClose();
         profit = NULL;
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit()>= TRISK) {
         //Print("ОРДЕР ПОКУПКИ ЗАРАБОТАЛ >= " + TRISK + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         profit = OrderProfit();
         //Print ("Новый профит = " + profit);
         //Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if ((profit>=TRISK && profit<TRISK*1.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK1))) || 
      (profit>=TRISK*1.5 && profit<TRISK*2 && profitUp && OrderProfit()<(profit-(profit/100*RISK2))) || 
      (profit>=TRISK*2 && profit<TRISK*2.5 && profitUp && OrderProfit()<(profit-(profit/100*RISK3))) || 
      (profit>=TRISK*2.5 && profit<TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK4))) || 
      (profit>=TRISK*3 && profitUp && OrderProfit()<(profit-(profit/100*RISK5)))) { 
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         BuyClose();
      }         
   }      
 //////////////////////////////////////////////////   
}