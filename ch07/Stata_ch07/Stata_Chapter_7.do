
Regression, Chapter 7

use "https://sites.google.com/site/econometriks/docs/housing_sales_88.dta", clear


*. Figure 7.3
scatter hprice sqrft , scheme(s2mono) ytitle("housing prices") ///
         || lfit hprice sqrft

*	Install outreg2, if required 
* Table 7.5

outreg2 using 88h_1.doc , label sum(log)  /// 
   eqkeep(mean sd min max)  replace	

*	Install htsummary, if required
*************** HTSUMMARY *************

htopen using ht_88, replace
htput <h1> Chapter 7 </h1>
htput <h2> Housing 88 </h2>
htput Murtaza Haider, November 11, 2014. Using Housing sales (88) as the example.
htclose

* Descriptive statistics

htopen using ht_88, replace
htput <h3> With Summary Statistics using builtin Stata </h3>
htlog sum
htclose

htopen using ht_88, append
htput <h3> Descriptive statistics on continuous variables </h3>
htsummary hprice, format(%8.0f) head
htsummary bdrms,  format(%8.2f)
htsummary lotsize, format(%8.2f) 
htsummary sqrft, format(%8.2f) close

htclose		 

	 
		 
******
* Figure 7.4
hist lotsize, bin(10) percent scheme(s2mono)		 

* Figure 7.5 & Table 7.6
reg hprice bdrms lotsize sqrft colonial
outreg2 using 88h_3.doc, label replace

* Table 7.7

htopen using ht_88, append
htput <h3> Descriptive statistics by categorical variables </h3>
htsummary hprice bdrms, format(%8.0f) head close
htclose	lotsize

* Table 7.8	 
reg hprice i.bdrms
outreg2 using 88h_2.doc, append		


* Table 7.9
reg hprice bdrms
outreg2 using 88h_4.doc, label replace
reg hprice bdrms lotsize
outreg2 using 88h_4.doc, label append
reg hprice bdrms sqrft
outreg2 using 88h_4.doc, label append
reg hprice bdrms lotsize sqrft
outreg2 using 88h_4.doc, label append
reg hprice bdrms lotsize sqrft colonial
outreg2 using 88h_4.doc, label append

* Table 7.11
reg lprice lsqrft
outreg2 using 88h_5.doc, label replace
reg lprice colonial
outreg2 using 88h_5.doc, label append
reg lprice bdrms bedsq		 
outreg2 using 88h_5.doc, label append


**********teaching evaluations ********

use "https://sites.google.com/site/econometriks/docs/beauty.dta", clear


*** Table 7.14 ***

reg eval female minority_inst english_speaker tenured upper single_credit beauty
outreg2 using teach_2.doc, label ctitle(un-weighted model) replace 

reg eval female minority_inst english_speaker tenured upper single_credit /// 
  beauty [aw=weight]
outreg2 using teach_2.doc, label ctitle(weighted model)  append

reg eval female minority_inst english_speaker tenured upper single_credit /// 
  beauty [aw=weight], vce(cluster prof)
outreg2 using teach_2.doc, label ctitle(weighted model, clustered standard errors)  append
		
************** HOUSEHOLD EXPENSES **************		

use "https://sites.google.com/site/econometriks/docs/hhld_expenses.dta", clear

* Table 7.16

outreg2 using hhld_1.doc , label sum(log)  /// 
   eqkeep(mean sd min max)  replace	


*** Table 7.17 alcohol ***

 bys kids: outreg2 using alcohol.doc, sum(log) eqkeep(mean N) keep(alcoh)  /// 
 replace label 

  /* Alternatively, use tabout and within Word, 
 Select Insert>Table>Convert text to Table */
 
tabout kids  using table10.doc, ///
c(mean alcoh) f(2c) sum layout(rb) h3(nil)  npos(both) style(tab) replace
 
* Table 7.18

reg alcoh adults
outreg2 using alcoh-1.doc, label ctitle(alcohol,) replace

reg alcoh adults income
outreg2 using alcoh-1.doc, label ctitle(alcohol,) append

reg alcoh adults income kids
outreg2 using alcoh-1.doc, label ctitle(alcohol,) append

reg alcoh adults income kids if kids>0
outreg2 using alcoh-1.doc, label ctitle(alcohol, households with no children) append

* Table 7.19
reg alcoh income i.adults i.kids
outreg2 using alcoh-2.doc, label ctitle(alcohol) replace


*** Food ***


*** Table 7.20 Food ***

 bys kids: outreg2 using food.doc, sum(log) eqkeep(mean N) keep(food)  /// 
 replace label 
 
 /* Alternatively, use tabout and within Word, 
 Select Insert>Table>Convert text to Table */
 
 tabout kids  using table10.doc, ///
c(mean food) f(2c) sum layout(rb) h3(nil)  npos(both) style(tab) replace

* Table 7.21
reg food adults 
outreg2 using food-1.doc, label ctitle(food,) replace

reg food adults income 
outreg2 using food-1.doc, label ctitle(food,) append

reg food adults income kids
outreg2 using food-1.doc, label ctitle(food,) append

reg food adults income kids if kids>0
outreg2 using food-1.doc, label ctitle(food, households with no children) append

* Table 7.22

reg food income i.adults i.kids
outreg2 using food-2.doc, label ctitle(food) replace

		 
***************************		 
** HETEROSKEDASTICITY **	

* Table 7.23	 
reg hprice lotsize sqrft bdrms
outreg2 using bp-1.doc, label ctitle(BP test,original model) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) replace
estat hettest

predict _res1, residuals
gen _res2= _res1^2


reg _res2 lotsize sqrft bdrms
outreg2 using bp-1.doc, label ctitle(BP test,res-squared model)  /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) append 

** log transformed **

* Table 7.24
reg lprice llotsize lsqrft lnrooms
outreg2 using bp-2.doc, label ctitle(BP Test,Log-Transformed Model) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) replace
estat hettest

predict _res1a, residuals
gen _res2a= _res1a^2

reg _res2a llotsize lsqrft lnrooms
outreg2 using bp-2.doc, label ctitle(BP Test,Res-Squared Model)  /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) append 

*__________Robust Standard Errors		 

* Table 7.25
		
reg hprice lotsize sqrft bdrms
outreg2 using bp-3.doc, label ctitle(dep_var: house price, regular standard errors) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) replace

reg hprice lotsize sqrft bdrms, vce(robust)
outreg2 using bp-3.doc, label ctitle(dep_var: house price, robust standard errors) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) append
		
		
		
*** Multicollinearity ***
* Table 7.26

reg hprice bdrms 
outreg2 using multi-1.doc, label ctitle(beds) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) replace

reg hprice bdrms sqrft
outreg2 using multi-1.doc, label ctitle(beds + sqrft) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) append

reg hprice bdrms sqrft lotsize
outreg2 using multi-1.doc, label ctitle(beds + sqrft +lotsize) /// 
adds(F-test, e(F),  Prob>F, e(p), Adj R-sqrd, e(r2_a)) append

pwcorr hprice bdrms sqrft lotsize, sig

************** 
