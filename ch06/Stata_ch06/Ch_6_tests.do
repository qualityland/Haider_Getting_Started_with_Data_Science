
/* Chapter 6 Hypothetically Speaking
Jan 05, 2016
*/

*********************** START HERE ************

/* Down load the file */

use https://sites.google.com/site/econometriks/docs/beauty.dta, clear

* Table 6.2
tabstat eval age beauty students allstudents, statistics( count mean sd semean )

* Fig. 6.8
histogram eval, bin(14) percent ytitle(Percent of Total) /// 
 xtitle(teaching evaluation score) scheme(s1manual) xsize(2.5) ysize(5)

* Fig. 6.9
twoway function y=normalden(x, 3.998, .554), range(1 7) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Normal Distribution") ///
subtitle("mean =3.998, sd=0.554") ///
legend(off)  scheme(sj)

* Fig. 6.10
drop norm_eval
gen norm_eval=(eval-3.998)/.554
histogram norm_eval, bin(14) percent ytitle(Percent of Total) /// 
 xtitle(teaching evaluation score) scheme(s1manual) xsize(2.5) ysize(5)
 
 * Fig. 6.11
 twoway function y=normalden(x, 3.998, .554), range(1 7) color(gs3) || ///
function y=normalden(x, 3.998, .554), range(4.5 7) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Normal Distribution") ///
subtitle("probability of obtaining teaching evaluation > 4.5") ///
legend(off) xlabel(0 1.64) ///
xtitle(teaching evaluation score) ///
xlabel(1 2 3 4 4.5 6 7) scheme(sj)

 * Fig. 6.12
 twoway function y=normalden(x, 3.998, .554), range(1 7) color(gs3) || ///
function y=normalden(x, 3.998, .554), range(1 4.5) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Normal Distribution") ///
subtitle("probability of obtaining teaching evaluation <= 4.5") ///
legend(off) xlabel(0 1.64) /// 
xtitle(teaching evaluation score) ///
xlabel(1 2 3 4 4.5 6 7) scheme(sj)


 * Fig. 6.14
 twoway function y=normalden(x, 3.998, .554), range(2 6) color(gs3) || ///
function y=normalden(x, 3.998, .554), range(3.5 4.2) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Normal Distribution") ///
subtitle("3.5 < Teaching evaluation <= 4.2") ///
legend(off) xlabel(0 1.64) /// 
xtitle(teaching evaluation score) ///
xlabel(1 2 3 3.5 4 4.2 5 6 7) scheme(sj)


* Fig. 6.16
twoway function y=normalden(x), range(-1.96 1.96) color(gs3) || ///
function y=normalden(x), range(-4 -1.96) recast(area) color(gs3) || ///
function y=normalden(x), range(1.96 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Two-tailed test") ///
subtitle("Normal Distribution") ///
legend(off) xlabel(-4 -3 -1.96 0 1.96 3 4) scheme(sj)

* Fig. 6.17
twoway function y=normalden(x), range(-1.96 4) color(gs3) || ///
function y=normalden(x), range(-4 -1.64) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("One-tailed test") ///
subtitle("Normal Distribution, left-sided") ///
legend(off) xlabel(-4 -3 -1.64 0 1.64 3 4) scheme(sj)

* Fig. 6.18
twoway function y=normalden(x), range(-4 4) color(gs3) || ///
function y=normalden(x), range(1.64 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("One-tailed test") ///
subtitle("Normal Distribution, right-sided") ///
legend(off) xlabel(-4 -3 -1.64 0 1.64 3 4) scheme(sj)


* Fig. 6.22
twoway function y=normalden(x), range(-1.96 1.96) color(gs3) || ///
function y=normalden(x), range(-4 -1.42) recast(area) color(gs9) || ///
function y=normalden(x), range(-4 -1.96) recast(area) color(gs3) || ///
function y=normalden(x), range(1.96 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Comparison of mean test") ///
subtitle("Normal Distribution") ///
legend(off) xlabel(-4 -3 -2 -1.42 0 2 3 4) scheme(sj)

* Fig. 6.23
twoway function y=normalden(x), range(-1.96 4) color(gs3) || ///
function y=normalden(x), range(-4 -1.49) recast(area) color(gs9) || ///
function y=normalden(x), range(-4 -1.64) recast(area) color(gs3) /// 
xtitle("{it: x}") ///
ytitle("Density") title("Comparison of mean test") ///
subtitle("one-tailed test") ///
legend(off) /// 
xlabel(-4 -3  -1.64 -1.49 0 1.64 3 4, labsize(vsmall) angle(90)) /// 
 scheme(sj)

* Fig. 6.24
twoway function y=normalden(x), range(-4 4) color(gs3) || ///
function y=normalden(x), range(1.64 4) recast(area) color(gs9) || ///
function y=normalden(x), range(2.24 4) recast(area) color(gs3) /// 
xtitle("{it: x}") ///
ytitle("Density") title("Comparison of mean test") ///
subtitle("one-tailed test, greater than test") ///
legend(off) /// 
xlabel(-4 -3  -1.64 0 1.64 2 2.24 3 4, labsize(vsmall) angle(90)) /// 
 scheme(sj)


* Fig. 6.25
twoway function y=tden(34,x), range(-4 4) color(gs3) || ///
function y=tden(34,x), range(-4 -2) recast(area) color(gs3) || ///
function y=tden(34,x), range(.95 4) recast(area) color(gs9) ||  ///
function y=tden(34,x), range(2 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Critial Values for {it: t}-distribution with 34 df") ///
subtitle("Two-tailed test") ///
legend(off) xlabel(-4 -2 0 0.95 2 4) scheme(sj)

* Table 6.5
table gender, contents(mean eval sd eval )

* Fig. 6.26
ttest eval, by(gender) unequal

* Fig. 6.27
twoway function y=tden(425.76,x), range(-4 4) color(gs3) || ///
function y=tden(425.76,x), range(-4 -2) recast(area) color(gs9) || ///
function y=tden(425.76,x), range(2 4) recast(area) color(gs9) || ///
function y=tden(425.76,x), range(3.27 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Critial Values for {it: t}-distribution with 425.76 df") ///
subtitle("Two-tailed test") ///
legend(off) xlabel(-4 -2 0 0.95 2 3.27 4) scheme(sj)

* Fig. 6.28
twoway function y=tden(425.76,x), range(-4 4) color(gs3) || ///
function y=tden(425.76,x), range(1.65 4) recast(area) color(gs9) || ///
function y=tden(425.76,x), range(3.27 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Critial Values for {it: t}-distribution with 425.76 df") ///
subtitle("Right-tailed test") ///
legend(off) xlabel(-4 -2 0  1.65 2 3.27 4, angle(90)) scheme(sj)


* Fig. 6.30
ttest eval, by(gender) 

* Fig. 6.31
twoway function y=tden(461,x), range(-4 4) color(gs3) || ///
function y=tden(461,x), range(-4 -2) recast(area) color(gs9) || ///
function y=tden(461,x), range(2 4) recast(area) color(gs9) || ///
function y=tden(461,x), range(3.25 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Critial Values for {it: t}-distribution with 461 df") ///
subtitle("Two-tailed test") ///
legend(off) xlabel(-4 -2 0 2 3.25 4) scheme(sj)


* Fig. 6.32
ttest eval, by(gender) // Look for  Ha: diff < 0

* Fig. 6.33
twoway function y=tden(461,x), range(-4 4) color(gs3) || ///
function y=tden(461,x), range(1.65 4) recast(area) color(gs9) || ///
function y=tden(461,x), range(3.25 4) recast(area) color(gs3) ///
xtitle("{it: x}") ///
ytitle("Density") title("Critial Values for {it: t}-distribution with 461 df") ///
subtitle("Right-tailed test") ///
legend(off) xlabel(-4 -2 0  1.65 2 3.25 4, angle(90)) scheme(sj)

* Fig. 6.35
ttest eval, by(gender) 

* Fig. 6.36
gen  gen2=.
replace gen2=1 if gender =="female"
replace gen2=2 if gender =="male"
label define gender2 1 "female" 2 "male"
label values gen2 gender2
label variable gen2 "instructor's gender"
tab gen*

reg eval i.gen2

* Fig. 6.37
* egen age_cat = cut(age), group(3) label 
egen age_cat = cut (age), at(0 44 59 75) label
tab age_cat

reg eval i.age_cat

* Fig. 6.38
anova eval age_cat

* Fig. 6.39
egen beauty_cat = cut (beauty), at(-1.5 -0.2586962 0.8808186 1.98 ) label
tab beauty_cat
anova eval beauty_cat

* Fig. 6.40
tab gender tenure, row  chi

