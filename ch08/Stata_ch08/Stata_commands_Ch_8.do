
 EXCEL FILE
 
 
*** January 15, 2016
** Download Data
use "https://sites.google.com/site/econometriks/docs/Stata_smoking.dta", clear

*** install html package. You can type the following in Stata without qoutes: "findit htopen'

* Table 8.4
htopen using ch8_tables, replace
htsummary smoker, head freq  format(%8.2f) rowtotal close


* Table 8.5
htsummary educ,  format(%8.1f) head 
htsummary age,  format(%8.1f)
htsummary income,  format(%8.0f)
htsummary pcigs79 ,  format(%8.1f)
htsummary smoker,  format(%8.2f) close


* Table 8.6
htsummary educ smoker,  format(%8.1f) head 
htsummary age smoker,  format(%8.1f)
htsummary income smoker,  format(%8.0f)
htsummary pcigs79 smoker,  format(%8.1f) close
htclose

** install outreg2 package before running the following commands.

* Table 8.7
reg smoker age educ income pcigs79
outreg2 using tab8-7.doc, replace label cttop(reg_income) adjr2 
reg smoker age educ inc_10k pcigs79
outreg2 using tab8-7.doc, append label cttop(reg_inc10k) adjr2 


** Figure 8.1

sum smoker age educ inc_10k pcigs79

reg smoker age educ inc_10k pcigs79

quietly: margins, at(age=(17(10)88))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(educ=(0(2)18))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(inc_10k=(0(.5)3))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(pcigs79=(46(5)80))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

** Figure 8.2
reg smoker age educ inc_10k pcigs79
avplots


*** LOGIT MODELS 

* Table 8.9
logit smoker age educ  pcigs79 income
outreg2 using tab8-9.doc, cttop(logit model) replace label  /// 
 addstat(Pseudo R-squared, `e(r2_p)')

** Table 8.10
 logit smoker age educ  pcigs79 income
outreg2 using tab8-10.doc, cttop(eform with income) replace label eform  /// 
 addstat(Pseudo R-squared, `e(r2_p)')
 
logit smoker age educ  pcigs79 inc_10k
outreg2 using tab8-10.doc, cttop(eform with inc_10k) append label eform  /// 
 addstat(Pseudo R-squared, `e(r2_p)')
 
 **  Figure 8.5
 
logit smoker age educ  pcigs79 inc_10k

quietly: margins, at(educ=(0(2)18))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(pcigs79=(46(5)70))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

** Figure 8.6
** you may need to install the Stata package sg152. 
*** net install spost9_ado.pkg

listcoef, help percent

* Fig. 8.7
prchange, help

*** PROBIT MODELS Figure 8.9

probit  smoker age educ inc_10k pcigs79


*** OLS, LOGIT, PROBIT MODELS
* Table 8.12

reg smoker age educ inc_10k pcigs79
outreg2 using tab8-12.doc, replace label cttop(OLS) adjr2 

logit smoker age educ  inc_10k pcigs79
outreg2 using tab8-12.doc, cttop(Logit) append label  /// 
 addstat(Pseudo R-squared, `e(r2_p)')

probit smoker age educ  inc_10k pcigs79
outreg2 using tab8-12.doc, cttop(Probit) append label  /// 
 addstat(Pseudo R-squared, `e(r2_p)')


 *** probit model figures ***
  **FIGURE 8.10 **
twoway function y=normalden(x), range(-4 4) color(gs3) || ///
function y=normalden(x), range( -4 -.469 ) recast(area) color(gs3) || ///
function y=normalden(x), range(.469 4) recast(area) color(gs3) ///
xtitle("{it: z}") ///
ytitle("Density") title("Illustration of hypothesis test") ///
subtitle("-z > Pr > z = 0.639") ///
legend(off) xlabel(-1.96 -.469 0 .469 1.96) scheme(sj)

 **FIGURE 8.11 **
twoway function y=normalden(x), range(-4 4) color(gs3) || ///
function y=normalden(x), range(-4 -.469) recast(area) color(gs3) ///
xtitle("{it: z}") ///
ytitle("Density") title("Illustration of hypothesis test") ///
subtitle("Pr < z = 0.320") ///
legend(off) xlabel(-1.64 -.469 0 ) scheme(sj)

di 1-normal(.469) + normal(-.469)
di normal(-.469)

di 1-normal(3.523) + normal(-3.523)
di 1-normal(5.357) + normal(-5.357)
di 1-normal(4.145) + normal(-4.145)
di 1-normal(2.129) + normal(-2.129)
di 1-normal(1.96) + normal(-1.96)

 **FIGURE 8.12 **
twoway function y=normalden(x), range(-4 4) color(gs3) || ///
function y=normalden(x), range(-4 -.3154) recast(area) color(gs3) ///
xtitle("{it: z}") ///
ytitle("Density") title("Probability calculations from Probit model") ///
subtitle("Pr < z = 0.3763") ///
legend(off) xlabel(-1.64 -.3154 ) scheme(sj)

di normal(-.3154)

** Figure 8.14

probit smoker age educ inc_10k pcigs79

quietly: margins, at(age=(17(10)88))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(educ=(0(2)18))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(inc_10k=(0(.5)3))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)

quietly: margins, at(pcigs79=(46(5)80))
marginsplot, recast(line) recastci(rarea) scheme(s2manual)




*** GROUPED LOGIT ***
use "https://sites.google.com/site/econometriks/docs/Stata_grouped_logit.dta", clear

/* Coding new variables
drop if hh_size ==0
drop if n_trips ==0

label variable hh_autos "Average autos per household"
label variable d_cbd "Distance from CBD"
label variable hh_size "Average persons per household"
label variable n_trips "Total number of trips"
label variable n_transit "Total transit trips"
*/

htopen using ch8_tables, append
htput  
htput Summary statistics
htput  
htsummary hh_autos,  format(%8.2f) head 
htsummary hh_size,  format(%8.2f)
htsummary d_cbd,  format(%8.1f)
htsummary n_trips ,  format(%8.0f)
htsummary n_transit,  format(%8.0f) close
htclose

** Table 8.16
glogit n_transit n_trips hh_autos hh_size d_cbd
outreg2 using tab8-16.doc, replace label cttop(Grouped Logit) adjr2 

** Figure 8.19
predict f_tran
label variable f_tran "Forecasted transit trips"
scatter  f_tran n_transit

** Table 8.17
blogit n_transit n_trips hh_autos hh_size d_cbd
outreg2 using tab8-17.doc, replace label cttop(Grouped Logit using blogit)  /// 
	addstat(Pseudo R-squared, `e(r2_p)')


****

