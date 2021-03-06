//+------------------------------------------------------------------+
//|                                                      _SET_BU.mq4 |
//|                      Copyright © 2009, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
void start(){
  int stlw=MarketInfo(Symbol(),MODE_STOPLEVEL);
  int spr =MarketInfo(Symbol(),MODE_SPREAD);  
  double prise=WindowPriceOnDropped();
  if(prise==0){
    Alert("Price is not defined!");
    return;
  } 
//----  
  for(int i=0;i<OrdersTotal();i++){
    if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
      if(OrderSymbol()==Symbol()){
        if(OrderCloseTime()==0){
          if(MathAbs(OrderOpenPrice()-prise)<spr*Point*2){
            int ticket=OrderTicket();
          }
        }  
      }
    }
  }
  if(ticket<1){
    Alert("order's not found!");
    return;  
  }
//----
  while(!IsStopped()){
    if(OrderSelect(ticket,SELECT_BY_TICKET)){
     if(OrderType()>1){Alert("Wrong order type");return;}
      if(OrderCloseTime()!=0){Alert("order is colsed");return;}
      if(NormalizeDouble(OrderOpenPrice(),Digits)==NormalizeDouble(OrderStopLoss(),Digits)){Alert("StopLoss Set");return;}
      if(OrderType()==0){  
        if(Bid-OrderOpenPrice()>stlw*Point){
          if(!OrderModify(ticket,OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,Blue)){
            Alert("StopLoss error",GetLastError());
            return;
          }else{PlaySound("expert.wav");}
        }else{
          RefreshRates();
          if(MathAbs(Bid-OrderOpenPrice())<2*Point){
            if(!OrderClose(ticket,OrderLots(),Bid,spr,Blue)){
              Print("Sell Order error",GetLastError());
            }else{PlaySound("expert.wav");}
          }
        }
      }
      if(OrderType()==1){  
        if(OrderOpenPrice()-Ask>stlw*Point){
          if(!OrderModify(ticket,OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,Blue)){
            Alert("StopLoss error",GetLastError());
            return;
          }else{PlaySound("expert.wav");}
        }else{
          RefreshRates();
          if(MathAbs(Ask-OrderOpenPrice())<2*Point){
            if(!OrderClose(ticket,OrderLots(),Ask,spr,Blue)){
              Print("Buy Order error",GetLastError());
            }else{PlaySound("expert.wav");}
          }
        }        
      }        
    }
  }
return;}
//+------------------------------------------------------------------+