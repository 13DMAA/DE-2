//+------------------------------------------------------------------+
//| Создает вертикальную линию                                       |
//+------------------------------------------------------------------+
bool VLineCreate(const long            chart_ID=0,        // ID графика
                 const string          name="VLine",      // имя линии
                 const int             sub_window=0,      // номер подокна
                 datetime              time=0,            // время линии
                 const color           clr=clrRed,        // цвет линии
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // стиль линии
                 const int             width=1,           // толщина линии
                 const bool            back=false,        // на заднем плане
                 const bool            selection=true,    // выделить для перемещений
                 const bool            hidden=true,       // скрыт в списке объектов
                 const long            z_order=0)         // приоритет на нажатие мышью
  {
//--- если время линии не задано, то проводим ее через последний бар
   if(!time)
      time=TimeCurrent();
//--- сбросим значение ошибки
   ResetLastError();
//--- создадим вертикальную линию
   if(!ObjectCreate(chart_ID,name,OBJ_VLINE,sub_window,time,0))
     {
      Print(__FUNCTION__,
            ": не удалось создать вертикальную линию! Код ошибки = ",GetLastError());
      return(false);
     }
//--- установим цвет линии
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- установим стиль отображения линии
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- установим толщину линии
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- отобразим на переднем (false) или заднем (true) плане
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- включим (true) или отключим (false) режим перемещения линии мышью
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
//| Перемещение вертикальной линии                                   |
//+------------------------------------------------------------------+
bool VLineMove(const long   chart_ID=0,   // ID графика
               const string name="VLine", // имя линии
               datetime     time=0)       // время линии
  {
//--- если время линии не задано, то перемещаем ее на последний бар
   if(!time)
      time=TimeCurrent();
//--- сбросим значение ошибки
   ResetLastError();
//--- переместим вертикальную линию
   if(!ObjectMove(chart_ID,name,0,time,0))
     {
      Print(__FUNCTION__,
            ": не удалось переместить вертикальную линию! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Удаляет вертикальную линию                                       |
//+------------------------------------------------------------------+
bool VLineDelete(const long   chart_ID=0,   // ID графика
                 const string name="VLine") // имя линии
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- удалим вертикальную линию
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": не удалось удалить вертикальную линию! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }