Proc format;
Value $MyelomaformatA
'A'="Stage 1"
'B'="Stage 1"     
'C'="Stage 2"
'D'="Stage 2"
'E'="Stage 3"
'F'="Stage 3" ;

* Step 3: Attach the format statement to the data set. ;
data work.myeloma5;
set work.myeloma4;
format 'Multiple Myeloma Stage'n $MyelomaformatA.; /* called imbalanced data*/
run;


proc univariate data=work.myeloma5 normaltest plots;  
	class 'Multiple Myeloma Stage'n; /*CATEGORICAL*/
	var CBC_MCHC; /*QUANTITATIVE*/
title;


TITLE "Table 1: Table to Compare Standard Deviations for Homogeneity";
PROC MEANS DATA = work.myeloma5 mean stddev VAR maxdec=4;
      class 'Multiple Myeloma Stage'n;  /*CATEGORICAL*/
      VAR CBC_MCHC;   /*QUANTITATIVE*/
RUN; 
TITLE;
/*IF YOU WANT A PVALUE FOR YOUR HOMOGENEITY TEST.... */

/*LEVENE'S TEST A Formal Hypothesis Check with a P-Value for Homogeneity*/
/* There are different variance tests that can be used to assess the equality of variances. These include:

    F-test: Compare the variances of two groups. The data must be normally distributed.
    Bartlett’s test: Compare the variances of two or more groups. The data must be normally distributed.
    ****Levene’s test: A robust alternative to the Bartlett’s test that is less sensitive to departures from normality.
    Fligner-Killeen’s test: a non-parametric test which is very robust against departures from normality.

******Note that, the Levene’s test is the most commonly used in the literature.
Source: https://www.datanovia.com/en/lessons/homogeneity-of-variance-test-in-r/
*/

proc ANOVA data=WORK.WEIGHTloss;
   class 'Diet Plan'n;
   model 'Weight Loss (lbs)'n = 'Diet Plan'n;
   means 'Diet Plan'n / hovtest=levene(type=SQUARED); /* second check on homogeneity */
run;
/* Conclusion: Since the p-value of .9110 is greater than the alpha of .05, we cannot reject Ho: The three data sets 
come from populations that have the same variances. The sample variances are homogeneous enough to pool.  */

/* Thus with normality of the x-bar distributions for all three diets and homogeneity of the X distributions 
for all three diets we choose ANOVA as the appropriate test. */

/************************************************************/
/*** END: Test Homogeneity ***/
/************************************************************/ 

/******************************************************************/
/**** BEGINNING: RANK THE DATA **********/
/********************************************************************/

proc rank data=WORK.myeloma5 out=work.rankings;
   var CBC_MCHC;
   ranks MCHC_RANKS;
run;

/* Check if your code worked. */

proc print data=WORK.rankings (obs=10);
run;
/******************************************************************/
/**** END: RANK THE DATA **********/
/********************************************************************/


/******************************************************************/
/**** BEGINNING: RUN THE WELCH TEST ON THE RANKS **********/
/********************************************************************/

TITLE1 "Welch Nonparametric Test for Mean RANK of";
Title2 "MCHC Levels by Multiple Myeloma Stage";
PROC GLM data=work.rankings order=internal;
 class 'Multiple Myeloma Stage'n;
 model MCHC_RANKS = 'Multiple Myeloma Stage'n;
 means 'Multiple Myeloma Stage'n / welch;
run;
quit;

/* You need this over all mean for everyone in all education groups to interpret 
the F statistic. */
Proc Means data=work.rankings n mean std maxdec=2;
var 'Rank of Hours of TV Watched'n;
run;

/* 
CONCLUSIONS

INTERPRETATION OF THE TEST STATISTIC: The between group variance of the RANKS 
FOR TVHOURS WATCHED is 9.91 times the variance of the within group variance. 

INTERPRETATION OF THE P-VALUE: There is a .01% chance of get sample RANKS for numbers of 
tv hours watched that create an F statistic of 9.91 or more when the mean 
tvhours for all five education levels is the same.

CONCLUSION OF Ho TEST: I am 95% confident that there is at least one 
education level that has a different mean RANK number of TV hours watched.
*/

/******************************************************************/
/**** END: RUN THE WELCH TEST ON THE RANKS **********/
/********************************************************************/





proc ANOVA data=WORK.myeloma5;
   class 'Multiple Myeloma Stage'n;
   model CBC_MCHC = 'Multiple Myeloma Stage'n;
   means 'Multiple Myeloma Stage'n / hovtest=levene(type=SQUARED);
run;
quit;


TITLE 'Figure 1: Stratified Vertical Confidence Intervals for Weight Loss by Diet Plan';
proc sgplot data=WORK.myeloma5 noautolegend;
vline 'Multiple Myeloma Stage'n / response= CBC_MCHC stat=mean limitstat=clm markers;
run;

TITLE 'Figure 1: Box Plot for MCHC by Multiple Myeloma Stage';
PROC sgplot data= WORK.myeloma5; 	/*Side-by-side box plot of SepalWidth by Species*/
	vbox CBC_MCHC / group= 'Multiple Myeloma Stage'n GROUPORDER=ascending;
	
	title 'Distribution of MCHC by Multiple Myeloma stage';
	yaxis label= 'MCHC (g/dl)';
	*yaxis grid values= (20 to 45 by 5);
	xaxis label= 'Multiple Myeloma stage';
	*ODS graphics
		/	attrpriority=none;
	styleattrs datacolors= ("#941D30" "#8B8C8E" "#3B8BD4");
	inset ("F-value:" = "6.11"
		"p:" = "<.0027") 
		/	position = bottomleft 
			title = 'Levene HOV Results'
			valuealign= LEFT
			border
			backcolor = white;
RUN;
TITLE;
ods graphics off;










TITLE 'Figure 1: Box Plot for MCHC Ranks by Multiple Myeloma Stage';
PROC sgplot data= work.rankings ; 	/*Side-by-side box plot of SepalWidth by Species*/
	vbox MCHC_Ranks / group= 'Multiple Myeloma Stage'n GROUPORDER=ascending;
	
	title 'Distribution of MCHC Ranks by Multiple Myeloma Stage';
	yaxis label= 'MCHC Ranks';
	*yaxis grid values= (20 to 45 by 5);
	xaxis label= 'Multiple Myeloma stage';
	*ODS graphics
		/	attrpriority=none;
	styleattrs datacolors= ("#941D30" "#8B8C8E" "#3B8BD4");
	inset ("F-value:" = "4.38"
		"p:" = "<.0207") 
		/	position = bottomleft 
			title = 'Welch ANOVA Results'
			valuealign= LEFT
			border
			backcolor = white;
RUN;
TITLE;
ods graphics off;


















Title "Figure 1: Histogram of Weight Loss by Diet"; 
proc sgplot data=WORK.myeloma5; 
	histogram CBC_MCHC / group= 'Multiple Myeloma Stage'n transparency=0.8 scale=count; 
	density CBC_MCHC/ type=normal group='Multiple Myeloma Stage'n lineattrs=(pattern=solid); 
	keylegend / location=inside position=topleft across=1; 
	Xaxis label = "Pounds Lost"; 
	Yaxis Label = "Diet Plan"; 
Run; 
Title; 


/* ask Dr. hardy how to properly fomrat this code? */
title "Histogram of MCHC levels stratified by Stage of Multiple Myeloma";
proc sgpanel data=work.myeloma5;
  panelby 'Multiple Myeloma Stage'n/ novarname rows=2 columns=1;
  histogram CBC_MCHC/ datalabel=proportion scale=proportion binwidth=50 group='Multiple Myeloma Stage'n;
  colaxis label="Amount of Weight Lost (pounds)" grid;
  rowaxis min=0 max=0.7 grid; /* Counter-intuitive: 0 and 0.7 are my limits for the y axis */
  refline 32 / LABEL="P" axis=x lineattrs=(pattern=shortdash color=blue); /* USE THE MEAN WHEN YOU ARE TESTING THE MEAN */
  refline 34 / LABEL="M" axis=x lineattrs=(pattern=shortdash color=red);
  refline 38 / LABEL="K" axis=x lineattrs=(pattern=shortdash color=green);
run;
