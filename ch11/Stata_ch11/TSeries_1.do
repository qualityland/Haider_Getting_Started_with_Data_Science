/*
CHAPTER 12 Time Series
July 5, 2014
J:\Research\All_else_being_equal\Chapters\Ch_12
*/

* Set working directory:
cd "J:\Research\All_else_being_equal\Chapters\Ch_12\Data"

/* Set time Series
findit tsmktim
net install dm81.pkg */


/* Other examples
tsmktim datevar, start(1970)
tsmktim datevar, start(1970q2)
tsmktim datevar, start(1970m5)
tsmktim datevar, start(1jul1970)
tsmktim datevar, start(1970q2) seq(ind)

Reference: Stata: The language of choice for time series analysis?
by Kit Baum. */

* Starting time series in January 1963
tsmktim datevar, start(1963m1)

*Generate t, year and months dummies
gen t= _n
egen month= seq () , f(1) t(12)
egen year= seq () , f(1963) t(2014) b(12)


{

* Start with Plotting
twoway (tsline med_home_price)
graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig01.png",  ///
 as(png) replace
 
** With details
twoway (tsline med_home_price), ttitle(Months) ///
 title(Median housing prices in the United States) ///
 subtitle(Prices are in nominal dollars) ///
 ytitle(median house prices (nominal)) ytitle(, alignment(default)) /// 
 note(Data obtained from Federal Reserve Economic Data)
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig02.png",  ///
 as(png) replace 

* With details Starts
twoway (tsline raw_starts) if tin(2003m1, 2006m12), ttitle(Months) ///
 title(Monthly Housing Starts in the United States) ///
 subtitle(Starts are in thousands) ///
 note(Data obtained from Federal Reserve Economic Data) /// 
  scheme(s2mono)
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig03.png",  ///
 as(png) replace
 
** Combining the two graphs : Unemployment rate and Median home prices
 twoway (tsline unemp_rate) (tsline med_home_price, yaxis(2)) /// 
 if tin(2007m1, 2014m5) , ///
 ytitle(unemployment rate in percent) ytitle(, alignment(default)) /// 
 ytitle(Median home prices for new housing ($), axis(2)) ttitle(Months) /// 
 title(Unemployment rate and Median home prices in the US, size(medium)) ///
 note(Data obtained from Federal Reserve Economic Data) ///
 scheme(s2mono) 
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig04.png",  ///
 as(png) replace
 
 *** Basic regression model
 
reg med L.med
est store Reg_1
predict f_price_reg1
estat dwatson

twoway (tsline med_home_price) (tsline f_price_reg1),  ///
 scheme(s2mono) 
 
 twoway (tsline med_home_price) (tsline f_price_reg1) /// 
  if tin(2006m1, 2014m5),  ///
 scheme(s2mono) 

** With trend and seasonality
reg med L.med t i.month
est store Reg_2
predict f_price_reg2
estat dwatson

 twoway (tsline med_home_price) (tsline f_price_reg1) (tsline f_price_reg2) /// 
  if tin(2006m1, 2014m5),  ///
 scheme(s2mono) 

reg med_home_price t i.month
est store Reg_3
predict f_price_reg3
estat dwatson

est table Reg_1 Reg_2 Reg_3, star b(%7.3f) stats(N r2_a)

twoway (tsline med_home_price) (tsline f_price_reg3)  /// 
if tin(1963m1, 1982m12) , ttitle(Months) ///
 ytitle(Actual and predicted house prices) yline(0 22300)  scheme(s2mono) 
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig05.png",  ///
 as(png) replace
 

twoway (tsline med_home_price) (tsline f_price_reg1)  /// 
if tin(1963m1, 1982m12) , ttitle(Months) ///
 ytitle(Actual and predicted house prices)  scheme(s2mono) 
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig06.png",  ///
 as(png) replace
 
 }
 
 
 ** ECONOMETRICS
 {

 ac med_home_price, scheme(s2mono) xlabel(#20) ytitle (Autoccorrelation of US Starts)
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig07.png",  ///
 as(png) replace
 pac med_home_price, scheme(s2mono) xlabel(#20) ytitle (Partial autoccorrelation of US Starts)
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig08.png",  ///
 as(png) replace
 }
 
 
 *_______________
 
  * With details Starts
twoway (tsline raw_starts), ttitle(Months) ///
 title(Monthly Housing Starts in the United States) ///
 subtitle(Starts are in thousands) ///
 note(Data obtained from Federal Reserve Economic Data) /// 
  scheme(s2mono)
 
 
 * With details Unemployment Rates
twoway (tsline unemp_rate), ttitle(Months) ///
 title(Seasonally Adjusted Unemployment Rate in the US) ///
 subtitle(Reported only for those in the labor force) ///
 ytitle (unemployment rate in percent) ///
 note(Data obtained from Federal Reserve Economic Data)
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\unemp_colour.png",  ///
 as(png) replace
 
 **  Monochrome
 
 twoway (tsline unemp_rate), ttitle(Months) ///
 title(Monthly Unemployment Rate in the United States) ///
 subtitle(Reported only for those in the labor force) ///
 ytitle (unemployment rate in percent) ///
 note(Data obtained from Federal Reserve Economic Data) ///
 scheme(s2mono)
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\unemp_mono.png",  ///
 as(png) replace
 
 
 ** Combining the two graphs : Starts and Unemployment Rates
 
 twoway (tsline raw_starts) (tsline unemp_rate, yaxis(2)), /// 
 ytitle(housing starts in thousands) ytitle(, alignment(default)) /// 
 ytitle(unemployment rate in percent, axis(2)) ttitle(Months) /// 
 title(Housing Starts and unemployment rates in the US, size(medium)) ///
 note(Data obtained from Federal Reserve Economic Data) ///
 scheme(s2mono) 
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\starts_unemp.png",  ///
 as(png) replace
 
  ** Combining the two graphs : Starts and Median home prices
 
 twoway (tsline raw_starts) (tsline med_home_price, yaxis(2)), /// 
 ytitle(housing starts in thousands) ytitle(, alignment(default)) /// 
 ytitle(Median home prices for new housing ($), axis(2)) ttitle(Months) /// 
 title(Housing Starts and Median home prices in the US, size(medium)) ///
 note(Data obtained from Federal Reserve Economic Data) ///
 scheme(s2mono)
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\starts_price.png",  ///
 as(png) replace
 

 
 *Diebold replication
 
 drop f_price
 reg med_home_price L.med_home_price t i.month if tin(1963m1,2011m12)
 predict f_price, xb
 twoway (tsline med_home_price) (tsline f_price) ///
  if tin(2000m1, 2014m5) , ///
  scheme (s2mono)
  
  drop far_price
  arima med_home_price if tin(1963m1,2011m12), ar(1 2) nolog
  predict far_price
   twoway (tsline med_home_price) (tsline f_price) (tsline far_price) ///
  if tin(2010m1, 2014m5) 
