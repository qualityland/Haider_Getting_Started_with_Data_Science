
 EXCEL FILE
 
 
*** January 15, 2016
** Download Data
use "https://sites.google.com/site/econometriks/docs/laborforce.dta", clear

*** install html package. You can type the following in Stata without qoutes: "findit htopen'

label variable lfp "labor force participation"
label variable k5 "kids: 1 to 5 years"
label variable k618 "kids: 6 to 18 years"
label variable wc "wife attended college"
label variable hc "husband attended college"
label variable lwg "log of wife's wages"
label variable inc "hhld income excluding wife's"
label variable age "wife's age in years"

* Table 9.3
htopen using ch9_tables, replace
htsummary lfp, head freq  format(%8.2f) rowtotal close

* Table 9.4
htsummary lfp wc , head freq  format(%8.2f) rowtotal close

* Table 9.5
htsummary lfp hc, head freq  format(%8.2f) rowtotal close test

* Table 9.7
htsummary k5 lfp , head freq  format(%8.2f) row rowtotal 
htsummary k618 lfp ,  freq  format(%8.2f) row  rowtotal close
htsummary age lfp, head format(%8.2f) 
htsummary lwg lfp,  format(%8.2f) 
htsummary inc lfp,  format(%8.2f) close
htsummary wc lfp , head freq  format(%8.2f)  row rowtotal 
htsummary hc lfp ,  freq  format(%8.2f) row rowtotal close


* Table 9.16 & 9.17
htopen using ch9_dating, replace
htsummary sex metonline, head freq  format(%8.2f) row rowtotal 
htsummary mar metonline,  freq  format(%8.2f) row rowtotal 
htsummary email metonline,  freq  format(%8.2f) row rowtotal 
htsummary flirtonline metonline,  freq  format(%8.2f) row rowtotal 
htsummary community metonline,  freq  format(%8.2f) row rowtotal close

htclose

* Table 9.18 & 9.19

** install outreg2 package before running the following commands.

mlogit metonline i.sex i.cregion i.mar i.email i.flirtonline age i.community
outreg2 using tab9-18.doc, replace label cttop(logit) ///
 addstat(Pseudo R-squared, `e(r2_p)') 

 * Table 9.20

 outreg2 using tab9-20.doc, replace label cttop(logit RRR) /// 
 stats(coef) stnum(replace coef=(exp(coef)-1)*100) ///
 addstat(Pseudo R-squared, `e(r2_p)') 

 
** Table 9.21
 
gen datingbrand2= datingbrand
 replace datingbrand2 = . if datingbrand>4
label variable datingbrand2 "Which online dating sites have you used?"
label values datingbrand2 LABL

tab datingbrand2

htopen using tab_9_21, replace
htsummary sex datingbrand2, head freq  format(%8.2f) row rowtotal 
htsummary community datingbrand2,  freq  format(%8.2f) row rowtotal 
htsummary par datingbrand2,  freq  format(%8.2f) row rowtotal 
htsummary email datingbrand2,  freq  format(%8.2f) row rowtotal 
htsummary intmob datingbrand2,  freq  format(%8.2f) row rowtotal 
htsummary teletype datingbrand2,  freq  format(%8.2f) row rowtotal close

htclose

* Table 9.22
mlogit datingbrand2 i.sex i.community i.par i.email i.intmob i.teletype 
outreg2 using tab9-22.doc, replace label cttop(multinomial logit dating brand) ///
 addstat(Pseudo R-squared, `e(r2_p)') 

* Table 9.23
htopen using tab_9_23, replace
htsummary sex fonebrand, head freq  format(%8.2f) row rowtotal 
htsummary cregion fonebrand,  freq  format(%8.2f) row rowtotal 
htsummary mar fonebrand,  freq  format(%8.2f) row rowtotal 
htsummary par fonebrand,  freq  format(%8.2f) row rowtotal 
htsummary intuse fonebrand,  freq  format(%8.2f) row rowtotal 
htsummary email fonebrand,  freq  format(%8.2f) row rowtotal 
htsummary intmob fonebrand,  freq  format(%8.2f) row rowtotal 
htsummary teletype fonebrand,  freq  format(%8.2f) row rowtotal close

htclose

* Table 9.24
mlogit fonebrand i.sex i.cregion i.mar i.par i.email i.intuse i.email /// 
 i.intmob i.teletype, base(1) 
outreg2 using tab9-24.doc, replace label cttop(multinomial logit phone brand) ///
 addstat(Pseudo R-squared, `e(r2_p)') 


 * Table 9.25
mlogit fonebrand i.sex i.cregion i.mar i.par i.email i.intuse i.email /// 
 i.intmob i.teletype 
outreg2 using tab9-25.doc, replace label cttop(multinomial logit phone brand) ///
 addstat(Pseudo R-squared, `e(r2_p)') 
 
 
 *** HEALTH INSURANCE **
 
 use "https://sites.google.com/site/econometriks/docs/ins.dta", clear
 
 drop edu2
 encode(education), generate(edu2)
 * Table 9.26
htopen using tab_9_26, replace
htsummary hhi lfp, head freq  format(%8.2f) row rowtotal 
htsummary education lfp,  freq  format(%8.2f) row rowtotal 
htsummary race lfp,  freq  format(%8.2f) row rowtotal 
htsummary region lfp,  freq  format(%8.2f) row rowtotal 
htsummary experience lfp,    format(%8.2f) 
htsummary kidslt6 lfp,  format(%8.2f) 
htsummary kids618 lfp,  format(%8.2f) 
htsummary husby lfp,  format(%8.2f) close

htclose


* Table 9.27

mlogit lfp i.hhi i.education i.race i.hispanic experience exp2 exp3 kidslt6 /// 
 kids618 husby i.region [aw=mean_wt], base(1)
 
outreg2 using tab9-27.doc, replace label ///
 addstat(Pseudo R-squared, `e(r2_p)') 

 * Table 9.28
 outreg2 using tab9-28.doc, replace label eform ///
 addstat(Pseudo R-squared, `e(r2_p)') 
 
 * Table 9.29
 outreg2 using tab9-29.doc, replace label  ///
 stats(coef) stnum(replace coef=(exp(coef)-1)*100) ///
 addstat(Pseudo R-squared, `e(r2_p)') 
  

  **** CONDITIONAL LOGIT MODELS ****
use "https://sites.google.com/site/econometriks/docs/modechoice_hensher.dta", clear


label variable id "Person id"
label variable alt "Alternatives"
label variable chair "Air mode constant"
label variable hinc "Household income (’000)"
label variable psize "Party size"
label variable aasc "Air alternative-specific constant"
label variable tasc "Train alternative-specific constant"
label variable basc "Bus alternative-specific constant"
label variable casc "Car alternative-specific constant"
label variable psizea "Party size – air mode"
label variable mode "Chosen mode"
label variable twait "Terminal wait time"
label variable invc "In-vehicle cost"
label variable invt "In-vehicle time"
label variable gc "Generalized cost"
label variable mc "Binary choice"
label variable hinca "Income-air"
label variable hincb "Income-bus"
label variable hinct "Income-train"
label variable psizeb "Party size-bus"
label variable psizet "Party size-train"
label variable t "Dummy t"
label variable choice "Numeric choice"

   
 * Table 9.33
encode(mode), gen(mode2)
 
htopen using tab_9_33, replace
htsummary mode2, head freq  format(%8.2f)  close
 htclose

   
 * Table 9.34
htopen using tab_9_34, replace
htsummary twait alt, head   format(%8.2f),  if mc==1
htsummary invc alt,  format(%8.2f) ,  if mc==1 
htsummary invt alt, format(%8.2f)  ,  if mc==1
htsummary hinc alt, format(%8.2f)  ,  if mc==1
htsummary psize alt, format(%8.2f) close ,  if mc==1 
htclose


* Table 9.35
  
clogit  mc gc twait hinca aasc tasc basc , group(id)
outreg2 using tab9-35.doc, replace label cttop(base case car) ///
 addstat(Pseudo R-squared, `e(r2_p)') 

clogit  mc gc twait hinca casc tasc basc , group(id)
outreg2 using tab9-35.doc, append label cttop(base case air) ///
 addstat(Pseudo R-squared, `e(r2_p)') 
 
 ** Table 9.36
 
predict modeshare

htopen using tab_9_36, replace
htsummary modeshare alt,  head format(%8.2f) close
htclose
 
 