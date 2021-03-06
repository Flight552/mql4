//+------------------------------------------------------------------+
//|                                                     Fractals.mq4 |
//|                      Copyright ? 2005, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright ? 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Red
//---- input parameters

//---- buffers
double ExtUpFractalsBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicator buffers mapping  
    SetIndexBuffer(0,ExtUpFractalsBuffer);  
//---- drawing settings
    SetIndexStyle(0,DRAW_ARROW);
    SetIndexArrow(0,119);
//----
    SetIndexEmptyValue(0,0.0);
//---- name for DataWindow
    SetIndexLabel(0,"Fractal Up");
//---- initialization done   
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- TODO: add your code here
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    i,nCountedBars;
   bool   bFound;
   double dCurrent;
   nCountedBars=IndicatorCounted();
//---- last counted bar will be recounted    

   if(nCountedBars<=2)
      i=Bars-nCountedBars-3;
   if(nCountedBars>2)
     {
      nCountedBars--;
      i=Bars-nCountedBars-1;
     }
//----Up Fractals
   while(i>=2)
     {
      //----Fractals up
      bFound=false;
      dCurrent=High[i];
      if(dCurrent>High[i+1] && dCurrent>High[i+2] && dCurrent>High[i-1] && dCurrent>High[i-2])
        {
         bFound=true;
         ExtUpFractalsBuffer[i]=dCurrent;
        }
      //----6 bars Fractal
      if(!bFound && (Bars-i-1)>=3)
        {
         if(dCurrent==High[i+1] && dCurrent>High[i+2] && dCurrent>High[i+3] &&
            dCurrent>High[i-1] && dCurrent>High[i-2])
           {
            bFound=true;
            ExtUpFractalsBuffer[i]=dCurrent;
           }
        }         
      //----7 bars Fractal
      if(!bFound && (Bars-i-1)>=4)
        {   
         if(dCurrent>=High[i+1] && dCurrent==High[i+2] && dCurrent>High[i+3] && dCurrent>High[i+4] &&
            dCurrent>High[i-1] && dCurrent>High[i-2])
           {
            bFound=true;
            ExtUpFractalsBuffer[i]=dCurrent;
           }
        }  
      //----8 bars Fractal                          
      if(!bFound && (Bars-i-1)>=5)
        {   
         if(dCurrent>=High[i+1] && dCurrent==High[i+2] && dCurrent==High[i+3] && dCurrent>High[i+4] && dCurrent>High[i+5] && 
            dCurrent>High[i-1] && dCurrent>High[i-2])
           {
            bFound=true;
            ExtUpFractalsBuffer[i]=dCurrent;
           }
        } 
      //----9 bars Fractal                                        
      if(!bFound && (Bars-i-1)>=6)
        {   
         if(dCurrent>=High[i+1] && dCurrent==High[i+2] && dCurrent>=High[i+3] && dCurrent==High[i+4] && dCurrent>High[i+5] && 
            dCurrent>High[i+6] && dCurrent>High[i-1] && dCurrent>High[i-2])
           {
            bFound=true;
            ExtUpFractalsBuffer[i]=dCurrent;
           }
        }                                    
                                        
      i--;
     }
     
//----
   return(0);
  }
//+------------------------------------------------------------------+