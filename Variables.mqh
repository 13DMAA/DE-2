MqlRates Array2M[];

double FiboArray[] = {-1,0,0.5,0.75}, ExtremumArray[][6], Masha[];

int marginis, Maintenance = 2000, minI, maxI, numberOrderBuy = NULL, numberOrderSell;

bool trend, impulse, orderBuyClose, orderSellClose, OrderBuyMustHave = false, profitUp = false;

double trendPrice, trendPriceNew, raznica = 0.00400, monthSpreads = 1.25, min, max, impulseUrovDown12 = NULL, impulseUrovUp12 = NULL, profit = NULL, priceBuy = NULL, priceSell = NULL;

datetime trendTime, trendPriceNewTime, minTime, maxTime, l2=NULL;
