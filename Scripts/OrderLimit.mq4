//+------------------------------------------------------------------+
//|                                       OpenBuySellLimitOrders.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <MagicNumber.mqh>
#include <Mql4Book\Trade.mqh>
#include <StopLevels.mqh>

double MS_Price=WindowPriceOnDropped();             // Открывает ордер по указателю мыши

int spread=int (NormalizeDouble((Ask-Bid)/Point, Digits));  //EurUsd=2, GbpUsd=3, Gold=5, Silver=5, UsjJpy=3, GBPCHF=7, UsdChf=3, EurJpy=3, UsdCad=4, GbpJpy=7, AudUsd=3
int open_ticket;
int gMagicNumber=0;

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
CTrade Trade;
CCount Count;

void OnStart()
  {
   foundMagicNumber();
   Trade.SetMagicNumber(gMagicNumber);
      
   if(MS_Price<Bid)
     {

      
      double SLB = NormalizeDouble(MS_Price - (gPips * _Point), Digits);    //order stop-loss
      open_ticket=OrderSend(_Symbol,OP_BUYLIMIT,gOrderLot,MS_Price,3,SLB,gTakeProfitBuy,NULL,gMagicNumber); // open order
                              

      Comment("Order - ",open_ticket);
     }

   if(MS_Price>Bid)
     {
    
         double SLS=NormalizeDouble(MS_Price + (gPips * _Point),Digits);    //order stop-loss
         open_ticket=OrderSend(_Symbol,OP_SELLLIMIT,gOrderLot,MS_Price,3,SLS,gTakeProfitSell,NULL,gMagicNumber); // open order

      Comment("Order - ",open_ticket);
     }

   int Error=GetLastError();

   Alert("Order accepted");
//---
   return;
  }
//+------------------------------------------------------------------+

bool foundMagicNumber()
  {
   string _symbol=_Symbol;
   gMagicNumber=pMagicNumber(_symbol);
   return true;
  }