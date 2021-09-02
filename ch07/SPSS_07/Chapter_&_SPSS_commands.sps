
DATASET ACTIVATE DataSet1.
* Fig. 7.3

STATS REGRESS PLOT YVARS=hprice XVARS=sqrft 
/OPTIONS CATEGORICAL=BARS GROUP=1 BOXPLOTS INDENT=15 YSCALE=75 
/FITLINES LINEAR APPLYTO=TOTAL.


* Table 7.5

DESCRIPTIVES VARIABLES=assess bdrms lotsize sqrft colonial lprice lassess llotsize lsqrft bedsq 
    lnrooms hprice
  /STATISTICS=MEAN STDDEV MIN MAX.

* Fig. 7.4

GRAPH
  /HISTOGRAM=lotsize.

* Fig. 7.5

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms lotsize sqrft colonial.

* Table 7.5

SUMMARIZE
  /TABLES=hprice BY bdrms
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN STDDEV.


* Table 7.8

SPSSINC CREATE DUMMIES VARIABLE=bdrms 
ROOTNAME1=newbeds 
/OPTIONS ORDER=A USEVALUELABELS=YES USEML=YES OMITFIRST=NO.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER newbeds_2 newbeds_3 newbeds_4 newbeds_5 newbeds_6.

* Table 7.9

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms lotsize.


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms  lotsize sqrft.


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms lotsize sqrft colonial.


* Table 7.11

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT lprice
  /METHOD=ENTER   lsqrft .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT lprice
  /METHOD=ENTER  colonial .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT lprice
  /METHOD=ENTER  bdrms bedsq.

* Table 7.13

DATASET ACTIVATE DataSet2.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT eval
  /METHOD=ENTER female.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT eval
  /METHOD=ENTER female minority_inst english_speaker.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT eval
  /METHOD=ENTER female minority_inst english_speaker tenured upper single_credit.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT eval
  /METHOD=ENTER female minority_inst english_speaker tenured upper single_credit beauty.

* Table 7.14

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT eval
  /METHOD=ENTER female minority_inst english_speaker tenured upper single_credit beauty.

REGRESSION
  /MISSING LISTWISE
  /REGWGT=weight
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT eval
  /METHOD=ENTER female minority_inst english_speaker tenured upper single_credit beauty.

* create a complex survey file using data preparation option. Use the unique prof id for luster and weights for weight.

* Complex Samples General Linear Model.
CSGLM  eval WITH female single_credit minority_inst upper english_speaker tenured beauty
  /PLAN FILE='C:\Users\Murtaza\Google Drive\AEBE\Data\ch.07\SPSS_07\test.csaplan2.csaplan'
  /MODEL female single_credit minority_inst upper english_speaker tenured beauty
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER SE TTEST
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.


* Household EXPENSES DAAT SET.

*. Table 7.16

DATASET ACTIVATE DataSet3.
DESCRIPTIVES VARIABLES=adults alcoh food kids trport income hhld nokids
  /STATISTICS=MEAN STDDEV MIN MAX.

* Table 7.17

SUMMARIZE
  /TABLES=alcoh BY kids
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN.

* Table 7.18

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT alcoh
  /METHOD=ENTER adults .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT alcoh
  /METHOD=ENTER adults income .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT alcoh
  /METHOD=ENTER adults income kids.

REGRESSION
  /SELECT=nokids EQ 0
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT alcoh
  /METHOD=ENTER adults income kids.

* Figure 7.7

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=kids MEAN(alcoh)[name="MEAN_alcoh"] MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: kids=col(source(s), name("kids"), unit.category())
  DATA: MEAN_alcoh=col(source(s), name("MEAN_alcoh"))
  GUIDE: axis(dim(1), label("children in household"))
  GUIDE: axis(dim(2), label("Mean weekly expenditure on alcohol"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: interval(position(kids*MEAN_alcoh), shape.interior(shape.square))
END GPL.


* Table 7.19

SPSSINC CREATE DUMMIES VARIABLE=adults 
ROOTNAME1=new_adults 
/OPTIONS ORDER=A USEVALUELABELS=YES USEML=YES OMITFIRST=NO.

SPSSINC CREATE DUMMIES VARIABLE=kids 
ROOTNAME1=new_kids 
/OPTIONS ORDER=A USEVALUELABELS=YES USEML=YES OMITFIRST=NO.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT alcoh
  /METHOD=ENTER income new_adults_2 new_adults_3 new_kids_2 new_kids_3 new_kids_4 new_kids_5.


*. Table 7.20

SUMMARIZE
  /TABLES=food BY kids
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN.

* Table 7.21

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT food
  /METHOD=ENTER adults .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT food
  /METHOD=ENTER adults income .

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT food
  /METHOD=ENTER adults income kids.

REGRESSION
  /SELECT=nokids EQ 0
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT food
  /METHOD=ENTER adults income kids.

* Table 7.22

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT food
  /METHOD=ENTER income new_adults_2 new_adults_3 new_kids_2 new_kids_3 new_kids_4 new_kids_5.

* Table 7.23

DATASET ACTIVATE DataSet1.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER lotsize sqrft bdrms
  /SAVE RESID.

DATASET ACTIVATE DataSet1.
COMPUTE resids2=RES_1**2.
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT resids2
  /METHOD=ENTER lotsize sqrft bdrms.


* Table 7.24

DATASET ACTIVATE DataSet1.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT lprice
  /METHOD=ENTER llotsize lsqrft lnrooms
  /SAVE RESID.

DATASET ACTIVATE DataSet1.
COMPUTE resids3=RES_2**2.
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT resids3
  /METHOD=ENTER llotsize lsqrft lnrooms.

* Table 7.25

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER lotsize sqrft bdrms.

COMPUTE ones=1.
EXECUTE.

* Create a complex survey data preperation file and use the ones variable as sample weight before running the following command.

* Complex Samples General Linear Model.
CSGLM  hprice WITH bdrms lotsize sqrft
  /PLAN FILE='C:\Users\Murtaza\Google Drive\AEBE\Data\ch.07\SPSS_07\robust.csaplan'
  /MODEL bdrms lotsize sqrft
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER SE TTEST
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.


* Table 7.26

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER bdrms.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER  sqrft bdrms.


REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hprice
  /METHOD=ENTER lotsize sqrft bdrms.
