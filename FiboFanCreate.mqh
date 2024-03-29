//+------------------------------------------------------------------+
//| Cоздает "Веер Фибоначчи" по заданным координатам                 |
//+------------------------------------------------------------------+
bool FiboFanCreate(datetime              time1=0,           // время первой точки
                   double                price1=0,          // цена первой точки
                   datetime              time2=0,           // время второй точки
                   double                price2=0,          // цена второй точки
                   const string          name="FiboFan",    // имя веера
                   const long            chart_ID=0,        // ID графика
                   const int             sub_window=0,      // номер подокна 
                   const color           clr=clrWheat,        // цвет линии веера
                   const ENUM_LINE_STYLE style=STYLE_SOLID, // стиль линии веера
                   const int             width=2,           // толщина линии веера
                   const bool            back=false,        // на заднем плане
                   const bool            selection=false,    // выделить для перемещений
                   const bool            hidden=false,       // скрыт в списке объектов
                   const long            z_order=0)         // приоритет на нажатие мышью
  {
//--- установим координаты точек привязки, если они не заданы
   ChangeFiboFanEmptyPoints(time1,price1,time2,price2);
//--- сбросим значение ошибки
   ResetLastError();
//--- создадим "Веер Фибоначчи" по заданным координатам
   if(!ObjectCreate(chart_ID,name,OBJ_FIBOFAN,sub_window,time1,price1,time2,price2))
     {
      //Print(__FUNCTION__,
      //      ": не удалось создать \"Веер Фибоначчи\"! Код ошибки = ",GetLastError());
      return(false);
     }
//--- установим цвет
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- установим стиль линии
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- установим толщину линии
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- отобразим на переднем (false) или заднем (true) плане
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- включим (true) или отключим (false) режим выделения веера для перемещений
//--- при создании графического объекта функцией ObjectCreate, по умолчанию объект
//--- нельзя выделить и перемещать. Внутри же этого метода параметр selection
//--- по умолчанию равен true, что позволяет выделять и перемещать этот объект
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- скроем (true) или отобразим (false) имя графического объекта в списке объектов
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- установим приоритет на получение события нажатия мыши на графике
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- успешное выполнение
   return(true);
  }
  //+------------------------------------------------------------------+
//| Задает количество уровней и их параметры                         |
//+------------------------------------------------------------------+
bool FiboFanLevelsSet(int             levels,         // количество линий уровня
                      double          &values[],      // значения линий уровня
                      const string    name="FiboFan", // имя веера
                      color           clr=clrWheat,      // цвет линий уровня
                      ENUM_LINE_STYLE style=STYLE_SOLID,      // стиль линий уровня
                      int             width=2,      // толщина линий уровня
                      const long      chart_ID=0)     // ID графика
  {

//--- установим количество уровней
   ObjectSetInteger(chart_ID,name,OBJPROP_LEVELS,levels);
//--- установим свойства уровней в цикле
   for(int i=0;i<levels;i++)
     {
      //--- значение уровня
      ObjectSetDouble(chart_ID,name,OBJPROP_LEVELVALUE,i,values[i]);
      //--- цвет уровня
      ObjectSetInteger(chart_ID,name,OBJPROP_LEVELCOLOR,i,clr);
      //--- стиль уровня
      ObjectSetInteger(chart_ID,name,OBJPROP_LEVELSTYLE,i,STYLE_SOLID);
      //--- толщина уровня
      ObjectSetInteger(chart_ID,name,OBJPROP_LEVELWIDTH,i,width);
      //--- описание уровня
      ObjectSetString(chart_ID,name,OBJPROP_LEVELTEXT,i,DoubleToString(100*values[i],1));
     }
//--- успешное выполнение
   return(true);
  }

//+------------------------------------------------------------------+
//| Удаляет "Веер Фибоначчи"                                         |
//+------------------------------------------------------------------+
bool FiboFanDelete(const long   chart_ID=0,     // ID графика
                   const string name="FiboFan") // имя веера
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- удалим веер
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": не удалось удалить \"Веер Фибоначчи\"! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет значения точек привязки "Веера Фибоначчи" и для        |
//| пустых значений устанавливает значения по умолчанию              |
//+------------------------------------------------------------------+
void ChangeFiboFanEmptyPoints(datetime &time1,double &price1,
                              datetime &time2,double &price2)
  {
//--- если время второй точки не задано, то она будет на текущем баре
   if(!time2)
      time2=TimeCurrent();
//--- если цена второй точки не задана, то она будет иметь значение Bid
   if(!price2)
      price2=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- если время первой точки не задано, то она лежит на 9 баров левее второй
   if(!time1)
     {
      //--- массив для приема времени открытия 10 последних баров
      datetime temp[10];
      CopyTime(Symbol(),Period(),time2,10,temp);
      //--- установим первую точку на 9 баров левее второй
      time1=temp[0];
     }
//--- если цена первой точки не задана, то сдвинем ее на 200 пунктов ниже второй
   if(!price1)
      price1=price2-200*SymbolInfoDouble(Symbol(),SYMBOL_POINT);
  }
