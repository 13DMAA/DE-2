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
   numberOrderBuy = OrderSend (Symbol(),OP_BUY,0.1,priceBuy,0,0,0,NULL,0,0,clrGreenYellow);
   ArrowUpCreate(TimeCurrent(),Ask,"Ордер покупки " + TimeToStr(TimeCurrent()),0,0,1,clrAqua);
}

void BuyClose () {
for (int i = 0;OrdersTotal()>0;i++) {// && OrderSelect(i,SELECT_BY_POS)==true
   orderBuyClose = OrderClose (OrderTicket(),0.1,Bid,0,clrBlue);
   }
   profit = NULL;
   profitUp = false;
   OrderBuyMustHave = false;
   numberOrderBuy = NULL;
   OrderBuyNow = NULL;
}

void Sell() {
   priceSell = Bid;
   numberOrderSell = OrderSend (Symbol(),OP_SELL,0.1,priceSell,0,0,0,NULL,0,0,clrRed);
   ArrowDownCreate(TimeCurrent(),Bid,"Ордер продажи " + TimeToStr(TimeCurrent()),0,0,1,clrPink);
}

void SellClose () {
for (int i = 0;OrdersTotal()>0;i++) {// && OrderSelect(i,SELECT_BY_POS)==true
   orderSellClose = OrderClose (OrderTicket(),0.1,Ask,0,clrOrange);
   }
   profit = NULL;
   profitUp = false;
   OrderBuyMustHave = false;
   numberOrderSell = NULL;   
   OrderBuyNow = NULL;
}

void Orders() {
   if (!trend && numberOrderBuy != NULL && OrdersTotal()>0) {
      orderBuyClose = OrderClose (numberOrderBuy,0.1,Bid,0,clrBlue);
      numberOrderBuy = NULL;
      profit = NULL;
      }
   if (trend && numberOrderSell != NULL && OrdersTotal()>0) {
      orderSellClose = OrderClose (numberOrderSell,0.1,Ask,0,clrOrange);
      numberOrderSell = NULL;
      profit = NULL;
      }
   if (!trend && OrderBuyMustHave == true && impulseUrovDown12!=NULL && Bid < impulseUrovDown12 && numberOrderSell == NULL && OrdersTotal()==0) {
      Sell();
      Print (numberOrderSell + " numberOrderSell");
      }
   if (OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true && numberOrderSell!=0 && OrdersTotal()>0 && OrderBuyNow == NULL && !trend && OrderBuyMustHave) {
         Print ("ОРДЕР ПРОДАЖИ ОТКРЫТ, ПРОФИТ == " + OrderProfit() + "                     " + TimeToStr(TimeCurrent()));
         if(!profitUp && OrderProfit()<= -40){
         SellClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
         Print(OrderProfit());
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit() >= 60) {
         Print("ОРДЕР ПРОДАЖИ ЗАРАБОТАЛ >= 60" + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         Print (OrderProfit() + " > " + profit);
         profit = OrderProfit();
         Print ("Новый профит = " + profit);
         Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if ((profitUp && OrderProfit()<(profit-(profit/100*30)))) {// || OrderProfit()>=40
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         SellClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
      }  
   }
   
//////////////////////////////////////////////////
   
   if (!trend && OrderBuyNow == 1 && numberOrderSell == NULL && OrdersTotal()==0) {
      Sell();
      Print (numberOrderSell + " numberOrderSell");
      OrderBuyNow = 2;
      }
   if (OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true && numberOrderSell!=0 && OrdersTotal()>0 && OrderBuyNow != NULL && !trend) {
         Print ("ОРДЕР ПРОДАЖИ ОТКРЫТ, ПРОФИТ === " + OrderProfit() + "                     " + TimeToStr(TimeCurrent()));
         if(OrderProfit()<= -15){
         SellClose();
         profit = NULL;
         Print(OrderProfit());
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (OrderProfit() >= 40) {
         Print("ОРДЕР ПРОДАЖИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         SellClose();
         profit = NULL;
      }
    }      
 //////////////////////////////////////////////////  
   
      if (trend && OrderBuyMustHave == true && impulseUrovUp12!=NULL && Ask > impulseUrovUp12 && numberOrderBuy == NULL && OrdersTotal()==0 && OrderBuyNow == NULL) {
      Buy();
      Print (numberOrderBuy + " numberOrderBuy");
      }
   if (OrderSelect(numberOrderBuy,SELECT_BY_TICKET)==true && numberOrderBuy!=0 && OrdersTotal()>0 && trend && OrderBuyMustHave) {
         Print ("ОРДЕР ПОКУПКИ ОТКРЫТ, ПРОФИТ == " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         if(!profitUp && OrderProfit()<= -40){
         BuyClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
         Print(OrderProfit());
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit()>= 60) {
         Print("ОРДЕР ПОКУПКИ ЗАРАБОТАЛ >= 60" + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         profit = OrderProfit();
         Print ("Новый профит = " + profit);
         Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if ((profitUp && OrderProfit()<(profit-(profit/100*30)))) {// || OrderProfit()>=40
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
         Print ("ОРДЕР ПОКУПКИ ОТКРЫТ, ПРОФИТ === " + OrderProfit() + "                     " + TimeToStr(TimeCurrent()));
         if(OrderProfit()<= -15){
         BuyClose();
         profit = NULL;
         Print(OrderProfit());
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (OrderProfit() >= 40) {
         Print("ОРДЕР ПОКУПКИ ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         BuyClose();
         profit = NULL;
      }
    }      
 //////////////////////////////////////////////////  
}