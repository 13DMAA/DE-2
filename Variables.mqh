MqlRates Array2M[];

double FiboArray[] = {-1,0,0.5,0.75}, ExtremumArray[][6], Masha[];

int marginis, Maintenance = 2000, minI, maxI, numberOrderBuy = NULL, numberOrderSell, OrderBuyNow = NULL;

bool FirstStartProgram = true, trend, impulse = false, orderBuyClose, orderSellClose, OrderBuyMustHave = false,
BuySell = false, profitUp = false, defenceBuySell = true, BUY = false, SELL = false;

double trendPrice, trendPriceNew, raznica = 0.00300, monthSpreads = 1.25, min, max, impulseUrovDown12 = NULL,
 impulseUrovDown14 = NULL, impulseUrovUp12 = NULL, impulseUrovUp14 = NULL, impulsesMin, impulsesMax,
  profit = NULL, priceBuy = NULL, priceSell = NULL, 
  SL = -40, TRISK = 40, RISK = NULL, RISK1 = 30, RISK2 = 25, RISK3 = 20, RISK4 = 15, RISK5 = 10, LOTS = 0.1,
   profitNow = NULL;//SL = -15, TRISK = 40, RISK = 30

datetime trendTime, trendPriceNewTime, minTime, maxTime, l2=NULL;
      double LowPriceNew = NULL, LowPricePost = NULL, HighPriceNew = NULL,
      HighPricePost = NULL, TrendCanalHighPoint = NULL;
      datetime LowPriceNewTime = NULL, LowPricePostTime = NULL, HighPriceNewTime = NULL,
      HighPricePostTime = NULL;