//+------------------------------------------------------------------+
//| Создает объект "Текст"                                           |
//+------------------------------------------------------------------+
bool TextCreate(
                const string            text="Text",              // сам текст
                datetime                time=0,                   // время точки привязки
                double                  price=0,                  // цена точки привязки
                const string            name="Text",              // имя объекта
                double                  angle=0.0,                // наклон текста
                const long              chart_ID=0,               // ID графика
                const int               sub_window=0,             // номер подокна
                const string            font="Arial",             // шрифт
                const int               font_size=15,             // размер шрифта
                const color             clr=clrWhite,               // цвет
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // способ привязки
                const bool              back=false,               // на заднем плане
                const bool              selection=false,          // выделить для перемещений
                const bool              hidden=true,              // скрыт в списке объектов
                const long              z_order=0)                // приоритет на нажатие мышью
  {
//--- установим координаты точки привязки, если они не заданы
   ChangeTextEmptyPoint(time,price);
//--- сбросим значение ошибки
   ResetLastError();
//--- создадим объект "Текст"
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {
      //Print(__FUNCTION__,
      //      ": не удалось создать объект \"Текст\"! Код ошибки = ",GetLastError());
      return(false);
     }
//--- установим текст
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- установим шрифт текста
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- установим размер шрифта
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- установим угол наклона текста
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- установим способ привязки
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- установим цвет
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- отобразим на переднем (false) или заднем (true) плане
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- включим (true) или отключим (false) режим перемещения объекта мышью
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
//| Перемещает точку привязки                                        |
//+------------------------------------------------------------------+
bool TextMove(const long   chart_ID=0,  // ID графика
              const string name="Text", // имя объекта
              datetime     time=0,      // координата времени точки привязки
              double       price=0)     // координата цены точки привязки
  {
//--- если координаты точки не заданы, то перемещаем ее на текущий бар с ценой Bid
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- сбросим значение ошибки
   ResetLastError();
//--- переместим точку привязки
   if(!ObjectMove(chart_ID,name,0,time,price))
     {
      Print(__FUNCTION__,
            ": не удалось переместить точку привязки! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Изменяет текст объекта                                           |
//+------------------------------------------------------------------+
bool TextChange(const long   chart_ID=0,  // ID графика
                const string name="Text", // имя объекта
                const string text="Text") // текст
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- изменим текст объекта
   if(!ObjectSetString(chart_ID,name,OBJPROP_TEXT,text))
     {
      Print(__FUNCTION__,
            ": не удалось изменить текст! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Удаляет объект "Текст"                                           |
//+------------------------------------------------------------------+
bool TextDelete(const long   chart_ID=0,  // ID графика
                const string name="Text") // имя объекта
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- удалим объект
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": не удалось удалить объект \"Текст\"! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет значения точки привязки и для пустых значений          |
//| устанавливает значения по умолчанию                              |
//+------------------------------------------------------------------+
void ChangeTextEmptyPoint(datetime &time,double &price)
  {
//--- если время точки не задано, то она будет на текущем баре
   if(!time)
      time=TimeCurrent();
//--- если цена точки не задана, то она будет иметь значение Bid
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
  }