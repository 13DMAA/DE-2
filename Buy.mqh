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
}

void BuyClose () {
for (;OrdersTotal()>0 && OrderSelect(numberOrderBuy,SELECT_BY_TICKET)==true;) {
   orderBuyClose = OrderClose (OrderTicket(),0.1,Bid,0,clrBlue);
   //numberOrderBuy == NULL;
   }
}

void Sell() {
   priceSell = Bid;
   numberOrderSell = OrderSend (Symbol(),OP_SELL,0.1,priceSell,0,0,0,NULL,0,0,clrRed);
}

void SellClose () {
   for (;OrdersTotal()>0 && OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true;) {
   orderSellClose = OrderClose (OrderTicket(),0.1,Ask,0,clrOrange);
   //numberOrderSell == NULL;
   }
}

void Orders() {
    
   if (!trend && OrderBuyMustHave == true && impulseUrovDown12!=NULL && Bid < impulseUrovDown12 && numberOrderSell == NULL) {
      Sell();
      Print (numberOrderSell + " numberOrderSell");
      OrderBuyMustHave = false;
      }
   if (OrderSelect(numberOrderSell,SELECT_BY_TICKET)==true && numberOrderSell!=0 && OrdersTotal()>0) {
         Print ("ОРДЕР ПРОДАЖИ ОТКРЫТ, ПРОФИТ = " + OrderProfit() + "                     " + TimeToStr(TimeCurrent()));
         if(!profitUp && OrderProfit()<-40){
         SellClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
         Print(OrderProfit());
         Print("ОРДЕР ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit()>100) {
         Print("ОРДЕР ЗАРАБОТАЛ > 100" + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         profit = OrderProfit();
         Print ("Новый профит = " + profit);
         Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if (profitUp && OrderProfit()<(profit-(profit/100*30))) {
         Print("ОРДЕР ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         SellClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
      }      
   }
   
   
   
   
      if (trend && OrderBuyMustHave == true && impulseUrovUp12!=NULL && Ask > impulseUrovUp12 && numberOrderBuy == NULL) {
      Buy();
      Print (numberOrderBuy + " numberOrderBuy");
      OrderBuyMustHave = false;
      }
   if (OrderSelect(numberOrderBuy,SELECT_BY_TICKET)==true && numberOrderBuy!=0 && OrdersTotal()>0) {
         Print ("ОРДЕР ПОКУПКИ ОТКРЫТ, ПРОФИТ = " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         if(!profitUp && OrderProfit()<-40){
         BuyClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
         Print(OrderProfit());
         Print("ОРДЕР ЗАКРЫТ В МИНУС " + OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         }
      if (!profitUp && OrderProfit()>100) {
         Print("ОРДЕР ЗАРАБОТАЛ > 100" + "                    " + TimeToStr(TimeCurrent()));
         profit = OrderProfit();
         profitUp = true;
         }
      if (profitUp && OrderProfit()>profit) {
         profit = OrderProfit();
         Print ("Новый профит = " + profit);
         Print ("СТОП установлен, когда профит " + (profit-(profit/100*30)));
         }
      if (profitUp && OrderProfit()<(profit-(profit/100*30))) {
         Print("ОРДЕР ЗАКРЫТ В ПЛЮС "+ OrderProfit() + "                    " + TimeToStr(TimeCurrent()));
         BuyClose();
         profit = NULL;
         profitUp = false;
         OrderBuyMustHave = false;
      }      
   }
}