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

void SearchExtremum () {
   for (int i=0; i < ArraySize(Array2M)-1;i++) {
         if (i == 0) {
         max = Array2M[i].high;
         maxTime = Array2M[i].time;
         min = Array2M[i].low;
         minTime = Array2M[i].time;
         }
         else {
            if (Array2M[i].high > max) {
            max = Array2M[i].high;
            maxTime = Array2M[i].time;
            maxI = i;
            }
            if (Array2M[i].low < min) {
            min = Array2M[i].low;
            minTime = Array2M[i].time;
            minI = i;
            }
         }
      }
      // рисуем линии над экстремумами
      ObjectsDeleteAll(0,"Line",0,OBJ_TREND);
      LineCreate (minTime-518400,min,TimeCurrent(),min,"LineMin "+min);
      LineCreate (maxTime-518400,max,TimeCurrent(),max,"LineMax "+max);
      
////////////////////////////////////////////////////////////
      
      
      
      
      //iMA(NULL,0,13,8,MODE_SMMA,PRICE_MEDIAN,i);
 }