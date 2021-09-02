
/* Chapter 4 Beauty Example
August 31, 2014
*/

* Set new working directory
cd "F:\Research\All_else_being_equal\Chapters\Ch_4\Stata"
use "K:\Research\All_else_being_equal\Chapters\Ch_4\Stata\beauty.dta", clear

*********************** START HERE ************

/* Down load the file */

use https://sites.google.com/site/econometriks/docs/beauty.dta

**********


****** Multi-way tabulations using Stata Log file *****

log using "F:\Research\All_else_being_equal\Chapters\Ch_4\Stata\Beauty results Chapter 4.smcl", replace
table gender tenure, contents(mean eval sd eval ) format (%8.2f)
log close

log using "F:\Research\All_else_being_equal\Chapters\Ch_4\Stata\Beauty results Chapter 4.smcl", append
table gender tenure minority,  contents(mean eval sd eval ) format (%8.2f)
table gender tenure, contents(mean eval sd eval ) by(minority) format (%8.2f)
log close

** Using log2html to convert smcl into html
log2html Beauty results Chapter 4, replace ti(Beauty study)



*** Hamermesh Table using Outreg2 *****

/* Weighted Data */

set more off
   
outreg2 using ham_weighted.doc [iw=students], label sum(log)  /// 
   eqkeep(mean sd) keep(eval female minority2 tenure2 english ) /// 
   cttop (all observations) replace

bys upper: outreg2 using ham_weighted.doc [iw=students], label sum(log)  /// 
   eqkeep(mean sd) keep(eval female minority2 tenure2 english ) ///
   cttop (division)
   
   
/* UN-Weighted Data */

outreg2 using ham_unweighted.doc , label sum(log)  /// 
   eqkeep( mean sd N ) keep(allstudents p_eval upper nprofs nprofs2 )  /// 
   cttop (all observations) replace

bys upper: outreg2 using ham_unweighted.doc , label sum(log)  /// 
   eqkeep(mean sd N ) keep(allstudents p_eval upper nprofs nprofs2 ) /// 
   cttop (division)
   

   
*************** HTSUMMARY *************


* Using htsummary, non-weighted data
htopen using ht_beauty, replace
htput <h1> Chapter 4 </h1>
htput <h2> Beauty example </h2>
htput Murtaza Haider, September 02, 2014. Using Beauty Pays as the example.
htclose

* Descriptive statistics

htopen using ht_beauty, append

htput <h3> With Summary Statistics using builtin Stata </h3>
htlog summarize age beauty eval students allstudents 
htclose

** Instructor specific atrtibutes **
htopen using ht_beauty, append
htput <h3> Descriptive statistics on continuous variables </h3>
htsummary age, format(%8.2f) head
htsummary age,  median
htsummary beauty, format(%8.2f) 
htsummary eval, format(%8.2f) 
htsummary students, format(%8.2f) 
htsummary allstudents, format(%8.2f) close

htlog sum age beauty if nprofs == 1
htclose


htopen using ht_beauty, append
htput <h3> Descriptive statistics by categorical variables </h3>
htsummary eval gender, format(%8.2f) head close
htsummary eval tenure, format(%8.2f) head close
htsummary gender tenure, freq head close
htlog table gender tenure, contents(mean eval sd eval freq )
htlog table gender tenure, contents(mean eval sd eval freq ) by(minority)

htclose


**  Weighted results using htsvysummary

htopen using ht_beauty, append
htput <h3> Weighted statistics </h3>

* Setting up survey data
/* declare survey design */
svyset, clear

* gen uid=_n
svyset  [iw=students]

* Summary stats
htsvysummary eval upper, format(%8.3f) head close
htclose

* Correlation

htopen using ht_beauty, append
htput <h3> Correlation matrix </h3>
htlog cor eval beauty age students allstudents
htclose

******* Hamermesh using htsummary ***************


htopen using ht_beauty, append
htput <h3> Hamermesh paper </h3>

htsvysummary eval upper, format(%8.3f) head 
htsummary allstudents upper, format(%8.3f) 
htsummary p_eval upper , format (%8.3f) 
htsvysummary female upper, freq   
htsvysummary minority upper, freq  
htsvysummary native upper, freq  
htsvysummary tenure upper, freq
htsummary nprofs upper, freq 
htsummary nprofs2 upper, freq  close
htclose


** Custom Table **
htopen using ht_beauty, append
htput <h1> Statistical Analysis using custom tables </h1>

htput <table border=1>
htput <tr>
htput <th>Variable</th>
htput <th>Mean</th>
htput <th>SD</th>
htput <th>Min</th>
htput <th>Max</th>
htput </tr>
foreach var of varlist eval beauty female upper nprofs nprofs2 {
local lab: var lab `var'
summarize `var'
local mean: display %8.2f r(mean)
local sd: display %8.2f r(sd)
local min: display %8.0f r(min)
local max: display %8.0f r(max)
htput <tr align=right>
htput <td>`lab'</td>
htput <td>`mean' </td>
htput <td>`sd' </td>
htput <td>`min' </td>
htput <td>`max' </td>
htput </tr>
}
htput </table>
htclose


****** Analysis conncludes here *******

** New Variables and labels

gen p_eval= students/allstudents* 100
label variable p_eval "percent responded"
label variable minority "minority"
label variable tenure "tenured"
label variable native "native speaker of English"
label variable age "prof's age"
label variable gender "gender"
label variable  credits "course credits"
label variable beauty "prof's beauty score"
label variable eval "evaluation score"
label variable division "division"
label variable students "students responded"
label variable  allstudents "students enrolled in class"
label variable prof "professors unique id"

gen upper = 0
replace upper = 1 if division == "upper"
label variable upper "division"
label define division 0 "lower" 1 "upper"
label values upper division

gen female = 0
replace female = 1 if gender == "female"
label variable female "female"
label define gender 0 "male" 1 "female"
label values female gender
tab female

label variable gender "Gender"
label variable division "Division"

** Professor unique values

by prof, sort: gen nprofs = _n == 1
replace nprofs=. if nprofs == 0 
label variable nprofs "faculty members (total)"
label define nprofs 0 "not unique" 1 "unique"
label values nprofs nprofs

by upper prof, sort: gen nprofs2 = _n == 1 
replace nprofs2=. if nprofs2 == 0
label variable nprofs2 "faculty members (divisional)"
label values nprofs2 nprofs


gen minority2=0
replace minority2 = 1 if minority == "yes"
label variable minority2 "minority"
label define yesno 1 "yes" 0 "no"
label values minority2 yesno


gen tenure2=0
replace tenure2 = 1 if tenure == "yes"
label variable tenure2 "tenured"
label values tenure2 yesno

gen english=0
replace english = 1 if native == "no"
label variable english "non-native English speaker"
label values english yesno









************ Concludes **************
