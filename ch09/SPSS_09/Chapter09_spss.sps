﻿* Encoding: UTF-8.

* SPSS Chapter 09: Multinomial

* Table 9.3
DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=lfp
  /ORDER=ANALYSIS.


* Table 9.4

CROSSTABS
  /TABLES=lfp BY wc
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

* Table 9.5

CROSSTABS
  /TABLES=lfp BY hc
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

* Table 9.7

CROSSTABS
  /TABLES=lfp BY k5 k618 wc hc
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.

SUMMARIZE
  /TABLES=age lwg inc BY lfp
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEAN.

* Table 9.8

* Generalized Linear Models.
GENLIN lfp (REFERENCE=FIRST) BY wc hc (ORDER=DESCENDING) WITH k5 k618 age lwg inc
  /MODEL wc hc k5 k618 age lwg inc INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION.

* Table 9.9

DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=cregion
  /ORDER=ANALYSIS.

* Table 9.10

DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=sex
  /ORDER=ANALYSIS.


* Table 9.11
DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=educ2
  /ORDER=ANALYSIS.


* Table 9.12

DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=lifequal
  /ORDER=ANALYSIS.


* Table 9.13

CROSSTABS
  /TABLES=mar BY romantic
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.


* Table 9.14

CROSSTABS
  /TABLES=meet BY sex
  /FORMAT=AVALUE TABLES
  /CELLS=COLUMN 
  /COUNT ROUND CELL.



* Table 9.4


DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=datingbrand
  /ORDER=ANALYSIS.


* Table 9.15

  
CROSSTABS
  /TABLES=sex BY metonline
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=mar  BY metonline
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES= email BY metonline
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=flirtonline BY metonline
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=community BY metonline
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.


* Table 9.17

DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=metonline
  /ORDER=ANALYSIS.

* Table 9.18

* Generalized Linear Models.
GENLIN metonline (REFERENCE=LAST) BY sex cregion mar email flirtonline community (ORDER=DESCENDING) 
    WITH age
  /MODEL sex cregion mar email flirtonline community age INTERCEPT=YES
 DISTRIBUTION=BINOMIAL LINK=LOGIT
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION.

* Table 9.21

RECODE datingbrand (1=1) (2=2) (3=3) (4=4) (ELSE=SYSMIS) INTO datebrand4.
VARIABLE LABELS  datebrand4 'online dating service'.
EXECUTE.


CROSSTABS
  /TABLES=sex BY datebrand4
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=community BY datebrand4
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=par  BY datebrand4
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=email BY datebrand4
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=intmob BY datebrand4
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=teletype BY datebrand4
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

* Table 9.22

NOMREG datebrand4 (BASE=FIRST ORDER=ASCENDING) BY sex community par email intmob teletype
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP MFI.

* Table 9.23

CROSSTABS
  /TABLES=sex  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=cregion  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=mar  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=par  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=intuse  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=email   BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES= intmob  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=teletype  BY fonebrand
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

* Table 9.24

NOMREG fonebrand (BASE=FIRST ORDER=ASCENDING) BY sex cregion mar par intuse email intmob teletype   
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP MFI.

* Table 9.25

NOMREG fonebrand (BASE=LAST ORDER=ASCENDING) BY sex cregion mar par intuse email intmob teletype
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP MFI.


* Table 9.26

CROSSTABS
  /TABLES= hhi BY lfp
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=education  BY lfp
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=race   BY lfp
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.

SUMMARIZE
  /TABLES=experience kidslt6 kids618 husby BY lfp
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=MEAN.

CROSSTABS
  /TABLES=region by lfp
  /FORMAT=AVALUE TABLES
  /CELLS=ROW 
  /COUNT ROUND CELL.


* Table 9.27 and 9.28


NOMREG lfp (BASE=FIRST ORDER=ASCENDING) BY hhi education race hispanic region WITH experience exp2 
    exp3 kidslt6 kids618 husby
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP MFI.

* Table 9.33

USE ALL.
COMPUTE filter_$=(mc = 1).
VARIABLE LABELS filter_$ 'mc = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

DATASET ACTIVATE DataSet2.
FREQUENCIES VARIABLES=alt
  /ORDER=ANALYSIS.


* Table 9.34

SUMMARIZE
  /TABLES=twait invc invt hinc psize BY alt
  /FORMAT=NOLIST TOTAL
  /TITLE='Case Summaries'
  /MISSING=VARIABLE
  /CELLS=COUNT MEAN STDDEV SEMEAN.

* Table 9.35

COMPUTE t=2-mc.
EXECUTE.

FILTER OFF.
USE ALL.
EXECUTE.

COXREG t
  /STATUS=mc(1)
  /STRATA=id
  /METHOD=ENTER aasc basc tasc gc twait hinca 
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20).

