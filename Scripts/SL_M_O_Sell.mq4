//+------------------------------------------------------------------+
//|                                                     SL Mause.mq4 |
//|                                                 Copyright © 2012 |
//|                                         http://cmillion.narod.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2012"
#property link      "http://cmillion.narod.ru"
extern bool    comment           = false;  //выводить информацию на экран
//+------------------------------------------------------------------+
#include <MagicNumber.mqh>
#include <Mql4Book\Trade.mqh>

int gMagicNumber=0;


int gBuy,gSell,gSellLimit,gBuyLimit,
    gBuyStop,gSellStop;

CTrade Trade;
CCount Count;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int Ticket;
   double value = NormalizeDouble(WindowPriceOnDropped(),Digits);
   string txt=StringConcatenate("Script SL ",DoubleToStr(value,Digits)," starts ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS));
   RefreshRates();
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;
      if(OrderSymbol()!=_Symbol)
         continue;
      Ticket = OrderTicket();
      double orderStopLoss = NormalizeDouble(OrderStopLoss(), Digits);
      double orderOpenPrice = NormalizeDouble(OrderOpenPrice(), Digits);

      if(OrderType()==OP_SELL)
        {
         if(value>Bid && orderOpenPrice != orderStopLoss)
           {
            if(OrderModify(Ticket,orderOpenPrice, value, OrderTakeProfit(),OrderExpiration(),White))
               txt = StringConcatenate(txt,"\nStopLoss is set ",DoubleToStr(value,Digits)," SELL order - ",Ticket);
            else
               txt = StringConcatenate(txt,"\nError ",GetLastError()," stoploss SELL by order ",Ticket);
           }
        }
      if(comment)
         Comment(txt);
     }
   if(comment)
     {
      Comment(txt,"\nScript finished at ", TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS));
     }
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

