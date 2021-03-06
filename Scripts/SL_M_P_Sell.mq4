//+------------------------------------------------------------------+
//|                                                     SL Mause.mq4 |
//|                                                 Copyright © 2012 |
//|                                         http://cmillion.narod.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2012"
#property link      "http://cmillion.narod.ru"
extern bool    comment           = true;  //выводить информацию на экран
//+------------------------------------------------------------------+
int start()
  {
   int Ticket;
   double value = NormalizeDouble(WindowPriceOnDropped(),Digits);
   string txt=StringConcatenate("Script SL ",DoubleToStr(value,Digits)," starts ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS));
   RefreshRates();
   RefreshRates();
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;
      if(OrderSymbol()!=Symbol())
         continue;

      Ticket = OrderTicket();
      
      if((OrderType()==OP_SELLSTOP) || (OrderType()==OP_SELLLIMIT))
        {
         if(value>OrderOpenPrice())
           {
            if(OrderModify(Ticket,OrderOpenPrice(),value, OrderTakeProfit(),OrderExpiration(),White))
               txt = StringConcatenate(txt,"\nStopLoss is set ",DoubleToStr(value,Digits)," SELL PENDING order - ",Ticket);
            else
               txt = StringConcatenate(txt,"\nError ",GetLastError()," stoploss SELL PENDING by order ",Ticket);
           }
        }
      if(comment)
         Comment(txt);
     }
   if(comment)
      Comment(txt,"\nScript finished at ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS));
   return(0);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
