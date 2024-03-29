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



//Print (TimeToStr(ObjectGet("IMPULSE 0 "+TimeToStr(maxTime),2)));


void Fibo () {
double FiboTimeEnd = NULL,FiboPriceEnd = NULL, FiboTimeStart = NULL, FiboPriceStart = NULL;
if (maxTime>minTime) {
   FiboTimeStart = maxTime;
   FiboPriceStart = max;
}
else if (minTime>maxTime) {
   FiboTimeStart = minTime;
   FiboPriceStart = min;
}
   if (ObjectFind(0,"IMPULSE 0 "+TimeToStr(FiboTimeStart))==0 || ObjectFind(0,"Trend 0 "+TimeToStr(FiboTimeStart))==0) {
      if (ObjectGet("IMPULSE 0 "+TimeToStr(FiboTimeStart),2)>0) {
         FiboTimeEnd = ObjectGet("IMPULSE 0 "+TimeToStr(FiboTimeStart),2);
         FiboPriceEnd = ObjectGet("IMPULSE 0 "+TimeToStr(FiboTimeStart),3);
      }
      else if (ObjectGet("Trend 0 "+TimeToStr(FiboTimeStart),2)>0) {
         FiboTimeEnd = ObjectGet("Trend 0 "+TimeToStr(FiboTimeStart),2);
         FiboPriceEnd = ObjectGet("Trend 0 "+TimeToStr(FiboTimeStart),3);
      }
      Print ("FIBO = " + (((FiboPriceEnd-FiboPriceStart)*10000)/((FiboTimeEnd - FiboTimeStart)/Period()/60)));
      //Print ("FIBO TIME END = " + TimeToStr(FiboTimeEnd));   
      //Print ("FIBO TIME START = " + TimeToStr(FiboTimeStart));
      Print ("FIBO TIME END - START = " + (FiboTimeEnd-FiboTimeStart)/Period()/60);
      Print ("FIBO PRICE END - START = " + (FiboPriceEnd-FiboPriceStart)*10000);
   }  
      FiboFanCreate(minTime,min,minTime+86400*3,min+0.0045977,"Fibo "+ min);
      FiboFanLevelsSet(4,FiboArray,"Fibo "+ min);
      
      
      FiboFanCreate(maxTime,max,maxTime+86400*3,max-0.0045977,"Fibo "+ max);
      FiboFanLevelsSet(4,FiboArray,"Fibo "+ max);
}