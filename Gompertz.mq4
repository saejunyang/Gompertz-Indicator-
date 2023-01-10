#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"
#property description "Gompertz"
#property strict

#property indicator_separate_window
#property indicator_buffers 1
#property indicator_color1 DodgerBlue
//--- input parameter
input int InpGomPeriod=20;  
//--- buffers
double ExtGomBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(void)
  {
   string short_name;
//--- 
   SetIndexStyle(0,DRAW_LINE);
   SetIndexBuffer(0,ExtGomBuffer);
//--- 
   short_name="Gom("+IntegerToString(InpGomPeriod)+")";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);
//--- check for input parameter
   if(InpGomPeriod<=0)
     {
      Print("Wrong input parameter Period=",InpGomPeriod);
      return(INIT_FAILED);
     }
//---
   SetIndexDrawBegin(0,InpGomPeriod);
//--- 
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                          |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   int i,limit;
//--- 
   if(rates_total<=InpGomPeriod || InpGomPeriod<=0)
      return(0);
//--- 
   ArraySetAsSeries(ExtGomBuffer,false);
   ArraySetAsSeries(close,false);
//--- 
   if(prev_calculated<=0)
     {
      for(i=0; i<InpGomPeriod; i++)
         ExtGomBuffer[i]=0.0;
      limit=InpGomPeriod;
     }
   else
      limit=prev_calculated-1;
//--- 
   for(i=limit; i<rates_total; i++)
      ExtGomBuffer[i]=(close[i]*close[i]*close[i-InpGomPeriod]/InpGomPeriod)*(MathLog(volume[i]/InpGomPeriod);
//--- done
   return(rates_total);
  }
//+------------------------------------------------------------------+
