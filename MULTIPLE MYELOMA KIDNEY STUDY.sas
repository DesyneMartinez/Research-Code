/* GOAL: FIND VARIABLES RELATED TO KIDNEY TESTING AND FUNCTIONING THAT YOU CAN PROVIDE AN ACTION ON*/
/* SEE IF ANY OF THESE FACTORS COMBINE WITH EACHOTHER HAVE ANY SIGNIFICANT OUTCOME TO COME TO A CONCLUSION
HIGH BLOOD PRESSURE ALREADY HAS A SIGNIFICANT OUTCOME WITH CREATININE CLEARANCE, SO THE GOAL IS TO FIND OTHERS THAT
ARE SIGNIFCANT WITH KIDNEY FUNCTIONING FOR MULTIPLE MYELOMA PATIENTS */
/* VARIABLES THAT RELATE TO KIDNEYS:
QUANTITATIVES
CREAT
CLAIR_CREAT
UREA 
B2M
FE (IRON)
CATEGORICALS
TOBACCO
BJP
HBP
DIABETE
24H_PROT
CHAIN (KAPPA OR LAMBDA)
/*


/* TRY TOBACCO USE FIRST */
Data WORK.MYELOMACREAT;
set work.myeloma5;
    if cmiss(of creat ) then delete;
run;
PROC FREQ DATA= WORK.MYELOMACREAT;
TABLES TOBACCO;
RUN;
/* CANT USE THE CENTRAL LIMIT THEOREM SO MUST CHECK FOR NORMALITY */
/* run a default QQ plot to get the QQ plot and Tests for normality */
title "Figure 3: QQ Plots";
proc univariate data=WORK.MYELOMAcreat normaltest plots; 
class TOBACCO; /* place categorical in your class statement */
VAR creat; /* place the quantitative in your variable statement */
run;
title;
/******************************Running the Proc TTest****************************/
/*  Run this as is to see if the data is already in an order that makes the difference positive. */
Proc ttest data=WORK.MYELOMAcreat Order=data plots sides=2 H0=0 alpha=.05;
	Class TOBACCO;   /*  categorical variable  */
	Var creaT;        /*  quantitative variable. */
run;
/* FOUND THAT CREAT IS A SIGNIFICANT OUTCOME FOR TOBACCO USE IN MULTIPLE MYELOMA PATIENTS */
/********************Running a Wilcoxon Rank sum Test Nonparametric *************************/
PROC NPAR1WAY DATA = WORK.MYELOMAcreat WILCOXON CORRECT=YES;
  CLASS TOBACCO;
  VAR CREAT;
RUN;
/* STATE WHY THESE AFFECT KIDNEYS AND HOW AN ACTION CAN BE USED */
/* The use of tobacco can have many adverse affects on your kidneys causing them to not 
work properly with their filtering process and can speed up the progression
of chronic kidney diseases. creatinine is a waste product of creatine which is used to supply
your muscles with energy. Healthy kidneys are able to filter out the creatine as creatinine 
but if the kidneys are not working properly it will cause a spike in creatinine levels that are 
indicative of kidney disease. Many multiple myeloma patients are prone to kidney disease so lowering the 
use of tobacco products can reduce the adverse affects on kidney functioning.
(source: the cleveland clinic) */

TITLE1 'Figure 1: Side by Side Boxplots of SCORE ON FINAL stratified by TEACHING METHOD';
title2 '(using the "VALUESHINT" command to set the y axis limits according to the data values)';
PROC SGPLOT DATA = WORK.MYELOMAcreat;
VBOX creat / CATEGORY=tobacco boxwidth=0.3 datalabel=creat displaystats=(n MEAN MAX Q3 MEDIAN Q1 MIN);
YAXIS LABEL = 'Score on the Final' VALUESHINT; /* "VALUES HINT" sets the y axis to the data range */
RUN;
title;

Proc ttest data=WORK.MYELOMAcreat Order=data plots sides=2 H0=0 alpha=.05;
	Class TOBACCO;   /*  categorical variable  */
	Var urea;        /*  quantitative variable. */
run;
/* FOUND THAT CREAT IS A SIGNIFICANT OUTCOME FOR TOBACCO USE IN MULTIPLE MYELOMA PATIENTS */
/********************Running a Wilcoxon Rank sum Test Nonparametric *************************/
PROC NPAR1WAY DATA = WORK.MYELOMAcreat WILCOXON CORRECT=YES;
  CLASS TOBACCO;
  VAR urea;
RUN;



Proc ttest data=WORK.MYELOMAcreat Order=data plots sides=2 H0=0 alpha=.05;
	Class TOBACCO;   /*  categorical variable  */
	Var clair_creat;        /*  quantitative variable. */
run;
/* FOUND THAT CREAT IS A SIGNIFICANT OUTCOME FOR TOBACCO USE IN MULTIPLE MYELOMA PATIENTS */
/********************Running a Wilcoxon Rank sum Test Nonparametric *************************/
PROC NPAR1WAY DATA = WORK.MYELOMAcreat WILCOXON CORRECT=YES;
  CLASS TOBACCO;
  VAR clair_creat;
RUN;

/**********************************************************************************/
/*** BEGINNING: Stratified Confidence Intervals ***/
/**********************************************************************************/

/*** Graphic: Stratified Confidence Interval *******************************/
/*** Graph of Confidence Intervals for Mean Sepal Widths by Species*********/
/*** Customized dimensions for better visibility without eating page space.*/
/*** Also rescaled slightly in Word for better text readability.
Source for data label attributes: https://blogs.sas.com/content/sgf/2017/09/15/proc-sgplot-theres-an-attrs-for-that/
************/

/* SET MAX DEC ON WEIGHT LOSS VARIABLE */
data work.MYELOMACREATMAXDEC;
set WORK.MYELOMAcreat;
format creat 6.2;
run;


ods graphics on / height=2.5 in width=5.5 in;
TITLE "95% Confidence Intervals for Mean WEIGHT LOSS by DIET";
proc sgplot data=work.MYELOMACREATMAXDEC;
    dot tobacco  / response=creat stat=mean 
    	datalabelattrs=(size=10 color="#13478C") 
    	limitstat=CLM datalabel=creat  alpha=0.05;
    yaxis label="Tobacco";
    xaxis label="creatinine levels";
run;
ods graphics off; /*IMPORTANT: this turns off the squished graphics. */
/**********************************************************************************/
/*** END: Stratified Confidence Intervals ***/
/**********************************************************************************/


/* TRY BJP */
Data WORK.MYELOMACREAT;
set work.myeloma5;
    if cmiss(of creat ) then delete;
run;
PROC FREQ DATA= WORK.myeloma5;
TABLES BJP;
RUN;
/* CANT USE THE CENTRAL LIMIT THEOREM SO MUST CHECK FOR NORMALITY */
/* run a default QQ plot to get the QQ plot and Tests for normality */
title "Figure 3: QQ Plots";
proc univariate data=WORK.MYELOMAcreat normaltest plots; 
class BJP; /* place categorical in your class statement */
VAR creaT; /* place the quantitative in your variable statement */
run;
title;
/******************************Running the Proc TTest****************************/
/*  Run this as is to see if the data is already in an order that makes the difference positive. */
Proc ttest data=WORK.MYELOMAcreat Order=data plots sides=2 H0=0 alpha=.05;
	Class BJP;   /*  categorical variable  */
	Var creaT;        /*  quantitative variable. */
run;
/* FOUND THAT CREAT IS A SIGNIFICANT OUTCOME FOR BJP PRESENCE IN MULTIPLE MYELOMA PATIENTS URINE 
P VALUE LESS THAN .0001 AND WE CAN SATTERWAITHE P VALUE .0018*/
/********************Running a Wilcoxon Rank sum Test Nonparametric *************************/
PROC NPAR1WAY DATA = WORK.MYELOMAcreat WILCOXON CORRECT=YES;
  CLASS BJP;
  VAR creat;
RUN;

/* FOUND THAT CREAT IS ALSO A SIGNIFICANT OUTCOME FOR BJP PRESENCE IN MULTIPLE MYELOMA PATIENTS URINE
FOR THE NONPARAMETRIC TEST P VALUE IS .0104 */
TITLE1 'Figure 1: Side by Side Boxplots of SCORE ON FINAL stratified by TEACHING METHOD';
title2 '(using the "VALUESHINT" command to set the y axis limits according to the data values)';
PROC SGPLOT DATA = WORK.MYELOMAcreat;
VBOX creat / CATEGORY=bjp boxwidth=0.3 datalabel=bjp displaystats=(n MEAN MAX Q3 MEDIAN Q1 MIN);
YAXIS LABEL = 'Score on the Final' VALUESHINT; /* "VALUES HINT" sets the y axis to the data range */
RUN;
title;






/* CLAIR_CREAT CHECK
UREA CHECK
/**/

Proc ttest data=WORK.MYELOMAcreat Order=data plots sides=2 H0=0 alpha=.05;
	Class BJP;   /*  categorical variable  */
	Var CLAIR_CREAT;        /*  quantitative variable. */
run;
/* FOUND THAT CLAIR_CREAT IS A SIGNIFICANT OUTCOME FOR BJP PRESENCE IN MULTIPLE MYELOMA PATIENTS URINE */
/********************Running a Wilcoxon Rank sum Test Nonparametric *************************/
PROC NPAR1WAY DATA = WORK.MYELOMAcreat WILCOXON CORRECT=YES;
  CLASS BJP;
  VAR CLAIR_CREAT;
RUN;

/***** using urea ********/
Data WORK.MYELOMAurea;
set work.myeloma5;
    if cmiss(of urea ) then delete;
run;


/******************ABSOLUTE STRONGEST OUTCOME FOR BJP FOR KIDNEY FUNCTION **********************/
title "Figure 3: QQ Plots";
proc univariate data=WORK.MYELOMAurea normaltest plots; 
class BJP; /* place categorical in your class statement */
VAR UREA; /* place the quantitative in your variable statement */
run;
title;
Proc ttest data=WORK.MYELOMAurea Order=data plots sides=2 H0=0 alpha=.05;
	Class BJP;   /*  categorical variable  */
	Var UREA;        /*  quantitative variable. */
run;
/* FOUND THAT UREA IS A SIGNIFICANT OUTCOME FOR BJP PRESENCE IN MULTIPLE MYELOMA PATIENTS URINE
P VALUE IS LESS THAN .0001 SO WE CAN USE THE SATTERWAITHE AND THE P VALUE IS .0003 */
/********************Running a Wilcoxon Rank sum Test Nonparametric *************************/
PROC NPAR1WAY DATA = WORK.MYELOMAurea WILCOXON CORRECT=YES;
  CLASS BJP;
  VAR UREA;
RUN;
/* SIGNIFICANT OUTCOME FOR THE NON PARAMETRIC TEST P VALUE .0016 */

/*STATE WHY THESE AFFECT KIDNEYS AND WHAT THE ACTION COULD BE */
/*Bence Jones proteins are small proteins produced by plasma cells that are
 small enough to pass through your kidneys. When your body has too many of these proteins,
 they easily pass from your bloodstream into your urine. Multiple Myeloma patients
 often have Bence Jones proteins in their urine. Healthy urine does not contain Bence Jones protein, 
 so its presence is an indication of a health problem. knowing that a blood urea test tests how well 
 your kidneys are able to filter out waste and excrete it out as urine the detection of bence jones proteins in 
 your blood would have a negative effect and cause you to have elevated urea levels damaging the kidneys.
 /* FIND AN ACTION FOR THIS!! 
 /* SYMPTOMS THAT A DOCTOR COULD SUSPECT THAT THEIR COULD BE BENCE JONES PROTEINS IN YOUR BLOOD IS
 bone pain or fracturing, particularly in the back, hips, or skull
confusion and or dizziness
weakness and swelling in the legs
multiple infections
/* SEEING OR EXPERIENCING ANY OF THESE SYMPTOMS EARLY SHOULD HAVE A PATIENT SEEK TREATMENT FASTER SO THAT THE BENCE JONES
PROTEINS CAN BE UNDER CONTROL SO THAT THE RATE FOR KIDNEY DAMAGE DOES NOT INCREASE BUT ALSO THE PROGRESSION OF MULTIPLE
MYELOMA DOES NOT SPEED UP BECAUSE BENCE JONES PROTEINS IS ANOTHER PIECE OF THE DIAGNOSES PUZZLE FOR INDICATING MULTIPLE
MYELOMA. 
(source peoplebeatingcancer.org )

/***** using urea ********/
Data WORK.MYELOMAurea;
set work.myeloma5;
    if cmiss(of urea ) then delete;
run;
/* converting urea from mmol to mg/dl  and changing the variable to BUN */
data work.myelomaurea;
    set work.myelomaurea;
    BUN = (urea*18);
run;


/* TRY 24H PROT */
proc format;
value $ureaFormat
0 = 'Not Present'
1 = 'Present';
run;
/* now I attach the formatted variable to the dataset */
Data work.myelomaurea;
set work.myelomaurea;
format '24h_Prot'n $ureaFormat.; /* this attaches the renamed levels to the original variable */
run;

title "Figure 3: QQ Plots";
proc univariate data=WORK.MYELOMAurea normaltest plots; 
class '24H_PROT'N; /* place categorical in your class statement */
VAR BUN; /* place the quantitative in your variable statement */
run;
title;
/******************************Running the Proc TTest****************************/
/*  Run this as is to see if the data is already in an order that makes the difference positive. */
Proc ttest data=WORK.MYELOMAurea Order=data plots sides=2 H0=0 alpha=.05;
	Class '24H_PROT'N;   /*  categorical variable  */
	Var BUN;        /*  quantitative variable. */
run;

PROC NPAR1WAY DATA = WORK.MYELOMAurea WILCOXON CORRECT=YES;
  CLASS'24H_PROT'N;
  VAR BUN;
RUN;


proc sort data=work.Myelomaurea;
key '24H_Prot'n/ ascending;
run;
TITLE 'Blood Urea Nitrogen levels by Presence of Protein in Urine';
PROC BOXPLOT data=work.myelomaurea; /*Check for homogeneity of variance with boxplot*/
 plot BUN*'24H_Prot'n / /*Quantitative by categorical*/
 	boxstyle=schematic 
 	cboxfill= "#941D30" ;    
RUN;
TITLE;



TITLE 'Figure 1: Box Plot for MCHC Ranks by Multiple Myeloma Stage';
PROC sgplot data= work.rankings ; 	/*Side-by-side box plot of SepalWidth by Species*/
	vbox MCHC_Ranks / group= 'Multiple Myeloma Stage'n GROUPORDER=ascending;
	
	title 'Distribution of MCHC Ranks by Multiple Myeloma Stage';
	yaxis label= 'MCHC Ranks';
	*yaxis grid values= (20 to 45 by 5);
	xaxis label= 'Multiple Myeloma stage';
	*ODS graphics
		/	attrpriority=none;
	styleattrs datacolors= ("#941D30");
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














proc gplot data= work.myelomaurea;
   plot BUN*'24H_Prot'n / haxis=axis1
                        vaxis=50 to 100 by 10;
run;

/* WHAT IS PROTEINURIA?
Proteinuria, also called albuminuria, is elevated protein in the urine. 
It is a symptom of certain conditions affecting the kidneys. 
Typically, when you have too much protein in the urine means that the kidneys’ filters
 are not working properly and are allowing too much protein to escape in the urine */
/* with urea the blood urea nitrogen (BUN) test helps test how well your kidneys are working.
so with if their is proteinuria present then that is a sign that your kidneys are not working well
and that your urea levels would be elevated */
/* but how can you cease elevated protein in the urine ?
 according to an article from kidneyandayurveda some tips to reduce elelvated protein intake are
Keep your salt intake low.
Avoid dairy products, packaged and canned foods
Increase your vegetables and fruits intake
these are all actionable steps! could be a preventive item 
/*(source john hopkins medicine, the mayoclinic, kidneyandayurveda  )*/

/* run a default QQ plot to get the QQ plot and Tests for normality */
title "Figure 3: QQ Plots";
proc univariate data=WORK.MYELOMA5 normaltest plots; 
class 'Multiple Myeloma Stage'n; /* place categorical in your class statement */
VAR body_surf; /* place the quantitative in your variable statement */
run;
title;
/******************************Running the Proc TTest****************************/
/*  Run this as is to see if the data is already in an order that makes the difference positive. */
Proc ttest data=WORK.MYELOMA5 Order=data plots sides=2 H0=0 alpha=.05;
	Class 'Multiple Myeloma Stage'n;   /*  categorical variable  */
	Var UREA;        /*  quantitative variable. */
run;
PROC NPAR1WAY DATA = WORK.MYELOMA5 WILCOXON CORRECT=YES;
  CLASS 'Multiple Myeloma Stage'n;
  VAR UREa;
RUN;


/***********code storage*************************/

data work.MYELOMAUREAMAXDEC;
set WORK.MYELOMAurea;
format urea 6.2;
run;

ods graphics on / height=2.5 in width=5.5 in;
TITLE "95% Confidence Intervals for Mean Urea Levels by Presence of Proteinuria";
proc sgplot data=work.MYELOMAUREAMAXDEC;
    dot '24H_PROT'N  / response=urea stat=mean 
    	datalabelattrs=(size=10 color="#13478C") 
    	limitstat=CLM datalabel=urea alpha=0.05;
    yaxis label="'24H_PROT'N";
    xaxis label="urea levels(mmol/l)";
run;
ods graphics off;

