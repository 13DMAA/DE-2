#include "ArrowDownCreate.mqh"
#include "ArrowUpCreate.mqh"
#include "Fibo.mqh"
#include "FiboFanCreate.mqh"
#include "FridayMonday.mqh"
#include "Impulses.mqh"
#include "LineCreate.mqh"
#include "Mashenka.mqh"
#include "RectangleCreate.mqh"
#include "SearchExtremum.mqh"
#include "VallarMarginis.mqh"
#include "Variables.mqh"
#include "Random.mqh"
#include "TextCreate.mqh"

void Impulses () {
   if (FirstStartProgram) {
      int i, j;
      if (maxTime > minTime) {
         trend = true;
         trendPrice = Array2M[minI].low;
         trendTime = Array2M[minI].time;
         impulsesMin = trendPrice;
         j=minI;
         }
      else if (minTime > maxTime) {
        trend = false;
        trendPrice = Array2M[maxI].high;
        trendTime = Array2M[maxI].time;
        impulsesMax = trendPrice;
        j=maxI;
      }
      if (TimeHour(Array2M[i].time)>=0 && TimeHour(Array2M[i].time)<=1) {
          LineCreate(Array2M[i].time,0.1,Array2M[i].time,2,"HOUR CLEANING"+TimeToStr(Array2M[i].time),clrGray,3,true);
         }
      for (i = j, trendPriceNew = trendPrice; i < ArraySize(Array2M); i++) {
//         //if (i == j) {
//         //TextCreate ("START",Array2M[i].time,Array2M[i].high+0.00100,"Text"+i);
//         //}
//         if (TimeHour(Array2M[i].time)>=0 && TimeHour(Array2M[i].time)<=1) {
//         LineCreate(Array2M[i].time,0.1,Array2M[i].time,2,"HOUR "+Array2M[i].time,clrGray,3,true);
//         }
          if (trend && Array2M[i].high >= trendPriceNew) {
            trendPriceNew = Array2M[i].high;
            //impulsesEnd = trendPriceNew;
            trendPriceNewTime = Array2M[i].time;
            //l2 = TimeCurrent();
            l2 = trendPriceNewTime;
            ObjectsDeleteAll(0,"NKZ_UP "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
            NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendTime + " " + trendPrice);
            if (!impulse && trendPriceNew > impulsesMax) {
               impulse = true;
               }
            if (!impulse && impulseUrovUp12!=NULL && impulseUrovUp12>0 && Array2M[i].close>impulseUrovUp12 && TimeHour(trendPriceNewTime)>=0 && TimeHour (trendPriceNewTime)<1) {
               impulse = true;
               ArrowUpCreate(Array2M[i].time,Array2M[i].close,"NKZ_Probitie1/2"+ TimeToStr(Array2M[i].time));
               TextCreate(DoubleToStr(impulseUrovUp12),Array2M[i].time,Array2M[i].high + 0.01000,"Text" + i,90);
               }
          }
          if (trend && (trendPriceNew-Array2M[i].high)>raznica) {
//            if (ObjectsDeleteAll(0,"NKZ_UP "+ trendPrice,0,OBJ_RECTANGLE)) {
//            //Print ("NKZ_UP "+ trendPrice + " DELETE!");
//            }
//            else
//            {
//            Print(__FUNCTION__,
//            ": не удалось удалить \"НКЗ\"! Код ошибки = ",GetLastError());
//            }
           if (!impulse){
                //OrderBuyMustHave = true;
               LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"Trend "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrGreenYellow);
               l2 = trendPriceNewTime;
               ObjectsDeleteAll(0,"NKZ_UP "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
               NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendTime + " " + trendPrice);
               impulseUrovUp14=NULL;
               impulseUrovUp12=NULL;
               }
           if (impulse && l2!= NULL) {
               //OrderBuyMustHave = false;
               l2 = trendPriceNewTime;
               LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"IMPULSE "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrViolet,5);
               impulsesMax = trendPriceNew;
               impulse = false;
               ObjectsDeleteAll(0,"NKZ_UP "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
               NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendTime + " " + trendPrice);
               impulseUrovUp14=NULL;
               impulseUrovUp12=NULL;
               }
          trendPrice = trendPriceNew;
          trendTime = trendPriceNewTime;
          trend = false;
          }
//         
          if (!trend && Array2M[i].low <= trendPriceNew) {
            trendPriceNew = Array2M[i].low;
            //impulsesEnd = trendPriceNew;
            trendPriceNewTime = Array2M[i].time;
            //l2 = TimeCurrent();
            l2 = trendPriceNewTime;
            ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
            NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendTime + " " + trendPrice);
            if (!impulse && trendPriceNew < impulsesMin) {
               impulse = true;
               }
            if (!impulse && impulseUrovDown12!=NULL && Array2M[i].close < impulseUrovDown12 && TimeHour(trendPriceNewTime)>=0 && TimeHour (trendPriceNewTime)<1) {
               impulse = true;
               ArrowDownCreate(Array2M[i].time,Array2M[i].close,"NKZ_Probitie1/2"+ TimeToStr(Array2M[i].time));
               TextCreate(DoubleToStr(impulseUrovDown12),Array2M[i].time,Array2M[i].low - 0.01000,"Text" + i,90);
               }
            }
//         
       if (!trend && (Array2M[i].low-trendPriceNew)>raznica) {
//            if (ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE)) {
//            //Print ("NKZ_DOWN "+ trendPrice + " DELETE!");
//            }
//            else
//            {
//            Print(__FUNCTION__,
//            ": не удалось удалить \"НКЗ\"! Код ошибки = ",GetLastError());
//            }
          if (!impulse) {
             //OrderBuyMustHave = true;
             LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"Trend "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrRed);
             l2 = trendPriceNewTime;
             ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
             NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendTime + " " + trendPrice);
             impulseUrovDown14=NULL;
             impulseUrovDown12=NULL;
             }
          if (impulse && l2!=NULL) {
             //OrderBuyMustHave = false;
             l2 = trendPriceNewTime;
             LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"IMPULSE "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrViolet,5);
             impulsesMin = trendPriceNew;
             impulse = false;
             ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
             NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendTime + " " + trendPrice);
             impulseUrovDown14=NULL;
             impulseUrovDown12=NULL;
             }
       trendPrice = trendPriceNew;
       trendTime = trendPriceNewTime;
       trend = true;
       }
    }
   FirstStartProgram = false;
   }
   ///////////////////////////////////////////
   if (!FirstStartProgram) {
      double HighPrice = iHigh(Symbol(),Period(),0);
      double LowPrice = iLow(Symbol(),Period(),0);
      double ClosePrice = iClose(Symbol(),Period(),0);
      datetime Now = TimeCurrent();
      if (TimeHour(Now)>=0 && TimeHour(Now)<=1) {
          LineCreate(Now,0.1,Now,2,"HOUR CLEANING"+TimeToStr(Now),clrGray,3,true);
         }
      if (trend && HighPrice >= trendPriceNew) {
          trendPriceNew = HighPrice;
            //impulsesEnd = trendPriceNew;
          trendPriceNewTime = Now;
            //l2 = TimeCurrent();
          l2 = trendPriceNewTime;
          ObjectsDeleteAll(0,"NKZ_UP "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
          NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendTime + " " + trendPrice);
          if (!impulse && trendPriceNew > impulsesMax) {
              impulse = true;
              }
            if (!impulse && impulseUrovUp12!=NULL && impulseUrovUp12>0 && ClosePrice>impulseUrovUp12 && TimeHour(trendPriceNewTime)>=0 && TimeHour (trendPriceNewTime)<1) {
               impulse = true;
               ArrowUpCreate(Now,ClosePrice,"NKZ_Probitie1/2"+ TimeToStr(Now));
               }
          }
          if (trend && (trendPriceNew-HighPrice)>raznica) {
//            if (ObjectsDeleteAll(0,"NKZ_UP "+ trendPrice,0,OBJ_RECTANGLE)) {
//            //Print ("NKZ_UP "+ trendPrice + " DELETE!");
//            }
//            else
//            {
//            Print(__FUNCTION__,
//            ": не удалось удалить \"НКЗ\"! Код ошибки = ",GetLastError());
//            }
           if (!impulse){
                OrderBuyMustHave = true;
               LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"Trend "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrGreenYellow);
               l2 = trendPriceNewTime;
               ObjectsDeleteAll(0,"NKZ_UP "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
               NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendTime + " " + trendPrice);
               impulseUrovUp14=NULL;
               impulseUrovUp12=NULL;
               }
           if (impulse && l2!= NULL) {
               OrderBuyMustHave = false;
               OrderBuyNow = 1;
               l2 = trendPriceNewTime;
               LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"IMPULSE "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrViolet,5);
               impulsesMax = trendPriceNew;
               impulse = false;
               ObjectsDeleteAll(0,"NKZ_UP "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
               NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendTime + " " + trendPrice);
               impulseUrovUp14=NULL;
               impulseUrovUp12=NULL;
               }
          trendPrice = trendPriceNew;
          trendTime = trendPriceNewTime;
          trend = false;
          }
//         
          if (!trend && LowPrice <= trendPriceNew) {
            trendPriceNew = LowPrice;
            //impulsesEnd = trendPriceNew;
            trendPriceNewTime = Now;
            //l2 = TimeCurrent();
            l2 = trendPriceNewTime;
            ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
            NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendTime + " " + trendPrice);
            if (!impulse && trendPriceNew < impulsesMin) {
               impulse = true;
               }
            if (!impulse && impulseUrovDown12!=NULL && ClosePrice < impulseUrovDown12 && TimeHour(trendPriceNewTime)>=0 && TimeHour (trendPriceNewTime)<1) {
               impulse = true;
               ArrowDownCreate(Now,ClosePrice,"NKZ_Probitie1/2"+ TimeToStr(Now));
               }
            }
//         
       if (!trend && (LowPrice-trendPriceNew)>raznica) {
//            if (ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE)) {
//            //Print ("NKZ_DOWN "+ trendPrice + " DELETE!");
//            }
//            else
//            {
//            Print(__FUNCTION__,
//            ": не удалось удалить \"НКЗ\"! Код ошибки = ",GetLastError());
//            }
          if (!impulse) {
             OrderBuyMustHave = true;
             LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"Trend "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrRed);
             l2 = trendPriceNewTime;
             ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
             NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendTime + " " + trendPrice);
             impulseUrovDown14=NULL;
             impulseUrovDown12=NULL;
             }
          if (impulse && l2!=NULL) {
             OrderBuyMustHave = false;
             OrderBuyNow = 1;
             l2 = trendPriceNewTime;
             LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"IMPULSE "+trend+" "+TimeToStr(trendTime) + " " + trendPrice,clrViolet,5);
             impulsesMin = trendPriceNew;
             impulse = false;
             ObjectsDeleteAll(0,"NKZ_DOWN "+ trendTime + " " + trendPrice,0,OBJ_RECTANGLE);
             NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendTime + " " + trendPrice);
             impulseUrovDown14=NULL;
             impulseUrovDown12=NULL;
             }
       trendPrice = trendPriceNew;
       trendTime = trendPriceNewTime;
       trend = true;
       }
  }
}