

** Stata - Chapter 5
** January 01, 2016

* Figure 5.2
scatter eval beauty

* Figure 5.3
twoway (scatter eval beauty), ytitle(teaching evaluation score) xtitle(normalized beauty score)

* Figure 5.5
twoway (scatter eval beauty, mcolor(gs10)) (lowess eval beauty, lcolor(gs0) /// 
lwidth(thick)), ytitle(teaching evaluation score) /// 
 xtitle(normalized beauty score) scheme(s1manual)

* Figure 5.6
twoway (scatter eval age, mcolor(gs10)) (lowess eval age, lcolor(gs0) /// 
lwidth(thick)), ytitle(teaching evaluation score) xtitle(age in years)  /// 
scheme(s1manual)

* Figure 5.8
 graph bar (count), over(minority) ytitle(number of courses) scheme(s1manual) note(minority status)
 
* Figure 5.9
 graph hbar (count), over(gender) ytitle(number of courses) scheme(s1manual)  

* Figure 5.11
graph bar (count), over(tenure) over(gender) ytitle(number of courses) /// 
asyvars stack scheme(s1manual)

* Figure 5.12
graph bar (count), over(tenure) over(gender) ytitle(number of courses) /// 
asyvars stack scheme(s1manual) percentages

* Figure 5.14
histogram beauty, bin(14) percent ytitle(Percent of Total) /// 
xtitle(normalized beauty score) scheme(s1manual)

* Figure 5.15
histogram beauty, bin(14) percent ytitle(Percent of Total) /// 
 xtitle(normalized beauty score) scheme(s1manual) xsize(2.5) ysize(5)

* Figure 5.19
graph box eval, over(minority) scheme(s1mono)

* Figure 5.20
ssc install spineplot

gen  gen2=.
replace gen2=1 if gender =="female"
replace gen2=2 if gender =="male"
label define gender 1 "female" 2 "male"
label values gen2 gender
label variable gen2 "instructor's gender"

gen  ten2= .
replace ten2=1 if tenure =="yes"
replace ten2=2 if tenure =="no"
label define tenure 1 "tenured" 2 "untenured"
label values ten2 tenure
label variable ten2 "tenure status"

spineplot gen2 ten2, scheme(s1mono) 

ytitle(gender) xtitle(tenure status)

* Figure 5.21
 graph bar (mean) allstudents, over(ten2) ytitle(number of enrolled students) ///
  scheme(s1manual)  

* Figure 5.22
 graph bar (mean) age, over(gen2) over(ten2) ytitle(average age of instructor) ///
  asyvars scheme(s1manual)  

* Figure 5.23
graph box age, over(gen2) scheme(s1mono) ytitle(average age of instructor)

* Figure 5.24
histogram eval, bin(14) percent ytitle(Percent of Total) /// 
xtitle(evaluation score) scheme(s1manual) by(gen2)

* Figure 5.26
histogram eval, bin(14) percent ytitle(Percent of Total) /// 
xtitle(evaluation score) scheme(s1manual) by(gen2 ten2)

* Figure 5.27
ssc install catplot
* use titanic, clear
collapse survived, by(age sex class)

catplot age sex [aw=100*survived], by(class, compact note("") col(1)) bar(1, blcolor(gs8) /// 
  bfcolor(gs14)) blabel(bar, format(%4.1f) pos(base)) subtitle(, pos(9) ring(1) bcolor(none) /// 
  nobexpand place(e)) ytitle(% survived from Titanic, place(e)) var1opts(gap(0)) var2opts(gap(*.2)) /// 
  outergap(*.2) ysize(5) yla(0(25)100, glcolor(gs14) glw(*.5)) 

* Figure 5.30
twoway (scatter eval beauty, mcolor(gs10)) (lowess eval beauty, lcolor(gs0) /// 
lwidth(thick)), ytitle(teaching evaluation score) /// 
 xtitle(normalized beauty score) scheme(s1manual)by(gen2)

* Figure 5.30
twoway (scatter eval beauty, mcolor(gs10)) (lowess eval beauty, lcolor(gs0) /// 
lwidth(thick)), ytitle(teaching evaluation score) /// 
 xtitle(normalized beauty score) scheme(s1manual)by(gen2 ten2)
 
 
* Figure 5.2
* Figure 5.2
* Figure 5.2
* Figure 5.2
* Figure 5.2
