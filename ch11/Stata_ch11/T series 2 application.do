/* Housing Starts application to Toronto 19887 - 2001

July 2014 

*/

* Declare time series
tsmktim datevar, start(1987m3)

* Toronto starts line plot
twoway (tsline to_st_to), ytitle(Housing Starts in Toronto)
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig09.png",  ///
 as(png) replace

* Toronto Starts ACF and PCF
ac to_st_to, scheme(s2mono) xlabel(#20) ytitle(Autocorrelations of Toronto Starts) 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig10.png",  ///
 as(png) replace
 pac to_st_to, scheme(s2mono) xlabel(#20) ytitle (Partial autocorrelation of Toronto Starts)
   graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig11.png",  ///
 as(png) replace

 
 * Toronto Starts ACF and PCF by TYPE
ac to_st_si, scheme(s2mono) xlabel(#20) ytitle("Autocorrelations of single-family detached" "housing starts") 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig12.png",  ///
 as(png) replace
 
 ac to_st_se, scheme(s2mono) xlabel(#20) ytitle (Autocorrelation of semi-detached housing starts)
   graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig13.png",  ///
 as(png) replace
 
  * Toronto Completions ACF and PCF by TYPE
ac to_com_s, scheme(s2mono) xlabel(#20) ytitle("Autocorrelations of single-family" "detached housing completions") 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig14.png",  ///
 as(png) replace
 
 ac v30, scheme(s2mono) xlabel(#20) ytitle ("Autocorrelation of semi-detached" "housing completions")
   graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig15.png",  ///
 as(png) replace
 
   * Toronto CCF starts and comps
xcorr to_st_to to_com_t, scheme(s2mono) xlabel(#20) /// 
title("Cross-correlogram between" "housing starts and completions") ///
ytitle("Cross correlation") 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig16.png",  ///
 as(png) replace
 
xcorr boc_rate to_st_to, scheme(s2mono) xlabel(#20) /// 
title("Cross-correlogram between" "Interest rate and housing starts") ///
ytitle("Cross correlation") 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig17.png",  ///
 as(png) replace
 
 
xcorr v15 to_st_to, scheme(s2mono) xlabel(#20) /// 
title("Cross-correlogram between" "5-year mortgage rate and housing starts") ///
ytitle("Cross correlation") 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig18.png",  ///
 as(png) replace
 
 
 *_______________________
 ** Regressions
 *_______________________
 
 label variable to_st_to "Toronto housing starts"
 * Plots
 twoway (tsline to_st_to) // Figure 09
 ac to_st_to // 12 month seasonality Fig. 10
 pac to_st_to // AR2 process Fig. 11
 
 * Unit root tests
 dfgls to_st_to //suggesting I(1)
 dfuller to_st_to, lag(12) // I(1)
 pperron to_st_to, lags(12) regress trend
 
 
 * OLS
 reg to_st_to L1.to_st_to
 est store reg1
 reg to_st_to L1.to_st_to L2.to_st_to i.year_
 est store reg2
 reg to_st_to L1.to_st_to L2.to_st_to i.year_ i.month_
 est store reg3
 est table reg1 reg2 reg3, star stat(N r2_a)
 
 predict regmod3
 label variable regmod3 "OLS model"
 predict resmod3, residuals
 
 corrgram resmod3
 wntestb resmod3, table
 dfuller resmod3, lags(12)
 
 twoway (tsline to_st_to) (tsline regmod3) , scheme(s2mono) ///
  title("Comparing actual housing starts" "and forecasted housing starts") ///
  ytitle("Toronto housing starts")
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig21.png",  ///
 as(png) replace
 
 *** Macro model
reg to_st_to L(1/3).to_st_to
est store regmod4
reg to_st_to L(1/3).to_st_to L(1/3).boc_rate  L(1/3).tse_300  L(1/3).v15
est store regmod5
est table regmod5, star stat(N r2_a)
predict resmod5, residuals
wntestb resmod5, table // p>.05, residuals not different from white noise

reg to_st_to  L(1/3).boc_rate  L(1/3).tse_300  L(1/3).v15
est store regmod6
est table regmod4 regmod5 regmod6, star stat(N r2_a) 
 
 *** VAR, out of sample forecasting
varsoc to_st_to to_com_t
var to_st_to to_com_t if tin(1987m3, 2000m5 )  , lags(1/3)
est store varmod1
est table varmod1, star stat(N aic)

predict resvar1, residuals
 wntestb resvar1, table // p>.05, residuals not different from white noise

fcast compute f_, step(18)
 
twoway (tsline to_st_to) (tsline regmod3) (tsline f_to_st_to) if tin(2000m5,), ///
 title("Toronto Starts, Regression, and VAR forecasts") ///
  ytitle("Toronto housing starts")  scheme(s2mono) 
   graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig22.png",  ///
 as(png) replace

 
 drop f_*
drop if _n>171


*** ARIMA
** Non differenced time sries
arima to_st_to, arima(1,0,0)
est store ar100
predict ar100, y
label variable ar100 "arima(1,0,0)"

arima to_st_to, arima(1,0,1)
est store ar101
predict ar101, y
label variable ar101 "arima(1,0,1)"

predict resar101, res
wntestb resar101, table // p>.05, residuals not different from white noise


arima to_st_to, arima(2,0,0)
est store ar200
predict ar200, y
label variable ar200 "arima(2,0,0)"

arima to_st_to, arima(2,0,1)
est store ar201
predict ar201, y
label variable ar201 "arima(2,0,1)"

predict resar201, res
wntestb resar201, table // p>.05, residuals not different from white noise


est table ar100 ar101 ar200 ar201, star stat(N aic bic ll) 

twoway  (tsline to_st_to) (tsline ar100) (tsline ar101) (tsline ar200) (tsline ar201), ///
  title("Toronto Starts, ARIMA models") ///
  ytitle("Toronto housing starts")  scheme(s2mono)
  
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig23.png",  ///
 as(png) replace

twoway  (tsline to_st_to) (tsline ar100) (tsline ar101) (tsline ar200)  ///
(tsline ar201) if tin(2000m1, 2001m5), scheme(s2mono) ///
  title("Toronto Starts, ARIMA models") ///
  ytitle("Toronto housing starts")  
  
 graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig24.png",  ///
 as(png) replace

** Differenced time series
clear
arima to_st_to, arima(1,1,0)
est store ar110
predict ar110, y
label variable ar110 "arima(1,1,0)"

arima to_st_to, arima(1,1,1)
est store ar111
predict ar111, y
label variable ar111 "arima(1,1,1)"

predict resar111, res
wntestb resar111, table // p>.05, residuals not different from white noise

arima to_st_to, arima(2,1,0)
est store ar210
predict ar210, y
label variable ar210 "arima(2,1,0)"

arima to_st_to, arima(2,1,1)
est store ar211
predict ar211, y
label variable ar211 "arima(2,0,1)"

predict resar211, res
wntestb resar211, table // p>.05, residuals not different from white noise

est table ar110 ar111 ar210 ar211, star stat(N aic bic ll) 

twoway  (tsline to_st_to) (tsline ar110) (tsline ar111) (tsline ar210)  ///
(tsline ar211), scheme (s2mono) ///
  title("Toronto Starts, ARIMA models" "with differenced time series") ///
  ytitle("Toronto housing starts") 
graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig25.png",  ///
 as(png) replace

twoway  (tsline to_st_to) (tsline ar110) (tsline ar111) (tsline ar210)  ///
(tsline ar211) if tin(2000m1, 2001m5), scheme (s2mono) ///
  title("Toronto Starts, ARIMA models" "with differenced time series") ///
  ytitle("Toronto housing starts") 

graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig26.png",  ///
 as(png) replace


*** OLS versus ARIMA
twoway  (tsline to_st_to) (tsline regmod3) (tsline ar111)   ///
if tin(2000m1, 2001m5), scheme (s2mono) ///
  title("OLS & ARIMA models" "with differenced time series") ///
  ytitle("Toronto housing starts") 
  graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig27.png",  ///
 as(png) replace

*** Out of sample forecasting.
**  Estimate 1987m3 - 2000m5, Forecast 2000m6 - 2001m5

arima to_st_to if tin(, 2000m5), arima(1,1,1)
est store arima111_oos
predict arima111_oos, y
label variable arima111_oos "arima(1,1,1) out of sample"

reg to_st_to L1.to_st_to L2.to_st_to i.year_ i.month_ if tin(, 2000m5)
 est store reg3oos
 predict regmod3_oos
 label variable regmod3_oos "Out of sample-OLS"

twoway  (tsline to_st_to) (tsline regmod3_oos) (tsline arima111_oos)  ///
if tin(2000m1,), scheme (s2mono) tline(2000m6) ///
  title("OLS & ARIMA models" "with differenced time series" "out of sample forecasts") ///
  ytitle("Toronto housing starts") 
  
graph export "J:\Research\All_else_being_equal\Chapters\Ch_12\Draft\12fig28.png",  ///
 as(png) replace


*** ARMAX with new housing prices
arima to_st_to L(1/6).house_in  , arima(1,1,1)
est store arimax111
arima to_st_to L.house_in  , arima(1,1,1)
est store arimax111a
est table  ar111 arimax111 arimax111a, star stat(N aic bic ll) 

/*
arima D.to_st_to , ar(1) ma(1 12)
predict ar1_ma_1_12,y
est store A
est table A, star stats(N ll aic bic)
arima D.to_st_to , ar(1 12) ma(1)
est store B
est table A B, star stats(N ll aic bic)
predict ar1_12_ma_1,y
twoway (tsline to_st_to) (tsline ar1_ma_1_12) (tsline ar1_12_ma_1) if tin(2000m1, 2001m5)
clear
use "J:\Research\All_else_being_equal\Chapters\Ch_12\Data\to_starts.dta", clear
*/


