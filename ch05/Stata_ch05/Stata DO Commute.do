

** Nov. 16, 2015 **


*** Distance bands
sort d_cbd
egen f_d_cbd= cut(d_cbd) , group(6) label
label define f_d_cbd 0 "nearest" 1 "nearer" 2 "medium near" 3 "medium far" 4 ///
 "farther" 5 "farthest" 6 "180.8-", replace
label variable f_d_cbd "distance bands"

** Income categories
egen f_m_hhinc= cut(m_hhinc) , group(3) label

** New commute time variables
seperate m_commtime, by(f_m_hhinc) veryshortlabel


*** Best dots differentiation with SJ scheme
scatter m_commtime? p_transit, mcolor(gs4 gs6 gs12) scheme(sj)  /// 
   msize(.7 .7 .7) by(f_d_cbd, rescale)  /// 
   ytitle("median commute times") xtitle("percent transit trips") ///
   legend(rows(1) label(1 "low inc") label(2 "med inc") label(3 "high inc"))
   
   

*** SJ theme is thte best
scatter m_commtime? p_transit,  msize(.7 .7 .7) scheme(sj) /// 
    by(f_d_cbd, rescale ) /// 
	legend(rows(1) label(1 "low inc") label(2 "med inc") label(3 "high inc"))
*******************

*** Three rows instead
scatter m_commtime? p_transit, msize(.7 .7 .7)  scheme(s2manual) /// 
    by(f_d_cbd, rescale rows(3)) /// 
	legend(rows(1) label(1 "low inc") label(2 "med inc") label(3 "high inc") )
***

scatter m_commtime? p_transit, msize(.7 .7 .7)  scheme(s1manual) /// 
    by(f_d_cbd, rescale) /// 
	legend(rows(1) label(1 "low inc") label(2 "med inc") label(3 "high inc") )
	
scatter m_commtime? p_transit, scheme(s1manual) /// 
    by(f_d_cbd, rescale) /// 
	legend(rows(1) label(1 "low inc") label(2 "med inc") label(3 "high inc") )
