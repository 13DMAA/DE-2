MqlRates Array2M[];

double FiboArray[] = {-1,0,0.5,0.75}, ExtremumArray[][6], Masha[];

int marginis, Maintenance = 2000, minI, maxI, numberOrderBuy = NULL, numberOrderSell, OrderBuyNow = NULL;

bool FirstStartProgram = true, trend, impulse = false, orderBuyClose, orderSellClose, OrderBuyMustHave = false, profitUp = false, defenceBuySell = true;

double trendPrice, trendPriceNew, raznica = 0.00400, monthSpreads = 1.25, min, max, impulseUrovDown12 = NULL, impulseUrovDown14 = NULL, impulseUrovUp12 = NULL, impulseUrovUp14 = NULL, impulsesMin, impulsesMax, profit = NULL, priceBuy = NULL, priceSell = NULL, SL = -40, TP = 40;

datetime trendTime, trendPriceNewTime, minTime, maxTime, l2=NULL;
