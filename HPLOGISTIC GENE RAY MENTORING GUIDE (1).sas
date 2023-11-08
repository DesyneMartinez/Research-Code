/*******************************************************************************************************************/
/********************************************************************************************************************/
/****************************************QUANTITATIVE PROCEDURE BELOW************************************************/
/*******************************************************************************************************************/
/*******************************************************************************************************************/

/* RAN THE PROC CORR FOR DR.RAY */
proc corr data= work.myeloma5;
	var CBC_MCHC alb TP  clair_creat CBC_HGB CBC_WBC CBC_MCV VS k ca na; /* r gets the residuals and Cook's D. r is not correlation here. */
run;
/*NO PROBLEMS WITH CORRELATED VARIABLES ALL VIFS ARE UNDER 2*/
/* DR.RAY LOOKES AT THE CORRELATIONS IN THE FIRST ROW OF EACH CELL
 NOT THE PVALUES AND LOOKS FOR SMALL VALUES TO MAKE SURE FOR NO HIGH CORRELATIONS
 BETWEEN VARIABLES */


/* PROC HPLOGISTIC CODE  */
/* ASK DR. RAY WHAT ALPHA LEVEL SHOULD BE USED HERE? */
/* ANSWER: THIS IS USING INFORMATION CRITERIA(AIC) AND NOT THE P VALUES */
Proc hplogistic data=WORK.myeloma5;
model 'Multiple Myeloma Stage'n= CBC_MCHC alb TP  clair_creat CBC_HGB CBC_WBC CBC_MCV VS k ca na ;
selection method = stepwise (SELECT=AIC CHOOSE=AIC);
run;
/* AFTER RUNNING THE CODE THE STEPWISE METHOD OUTPUT THE VARIABLES CBC_MCHC ALB
AND CLAIR_CREAT AS THE ONLY VIABLE CANDIDATES TO PREDICT STAGE 3 MYELOMA*/
/* THIS WOULD BE A VERY GOOD PIECE OF CODE TO TALK ABOUT AND EDUCATE OTHERS ON
WHILE PRESENTING YOUR POSTER! GET MORE INFO ON IT AND EXPLAIN EVERYTHING IN DETAIL! */


/* PROC LOGISTIC WITH GENE RAY*/ 
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= CBC_MCHC alb clair_creat;
	store p1;  /*STORING THE PREDICTIONS RANGING FROM 0 T0 1 DISPLAYING THE CHANCE OF HAVING STAGE 3 */
RUN;
QUIT;
/* THIS IS IMPORTANT FOR GETTING THOSE PREDICTORS AND GETTING THE PROBABILITY OF GETTING STAGE 3 AND EXAMINE THE IMPACT OF USING THE THREE VARIABLES
THAT CAME OUT SIGNIFICANT*/

/***********************Create a dataset with the five number summaries for each variable*********************************/
/*Nested do loop. Scoremyeloma uses the five number summary from the proc means to make a dataset to calculate 
the probability of having myeloma for each of the combinations of the significant predictors albumin CBC_MCHC and CLair_creat
Example:
14,28,.5
14,28,35
14,28,55
14,28,80
14,28,260
14,32,.5
14,32,35
14,32,55
14,32,80
14,32,260 
etc... 
*/


proc means data= work.myeloma5 min q1 median q3 max mean; 
var alb CBC_MCHC clair_creat;
run;
data scoremyeloma;
do alb = 14,29,34,39,49;
	do CBC_MCHC= 28,32,33,34,39;
		do clair_creat= .5,35,55,80,260;
			output;
		end;
	end;
end;
run;
/* GENE RAY WAS CHECKING WHETHER ALBUMIN HAD AN EFFECT ON PREDICTING BINARY 3 AND WHETHER ALBUMIN WAS WORTH
ADDING TO THE MODEL. THE PROC SORT SORTED SO THAT YOU CAN SEE THE EFFECT OF ALBUMIN ON THE PREDICTORS OF BINARY 3.
P1 WAS STORED IN THE PROC LOGISTIC CODE THAT WAS RUN AT LINE 31. P1 IS THE PREDICTED PROBABILITY OF HAVING MULTIPLE
MYELOMA STAGE 3 WITH THE X VALUES THAT WERE THE FIVE NUMBER SUMMARY COMBINATIONS. THE PREDICTORS ARE THE ANTI LOG OF THE LOGIT*/

/*The PLM procedure performs postfitting statistical analyses for the contents of a SAS item store that was previously created with the STORE statement in some other SAS/STAT procedure. An item 
store is a special SAS-defined binary file format used to store and restore information with a hierarchical structure.
The statements available in the PLM procedure are designed to reveal the contents of the source item store via the Output Delivery System (ODS) 
and to perform postfitting tasks such as the following:
testing hypotheses
computing confidence intervals
producing prediction plots
scoring a new data set */
/* THIS CODE CREATES THE PREDICTED PROBABILITIES AND IT GIVES YOU THE SPECIFIC PROBABILITY FOR THE COVARIATES */
proc plm restore=p1 ;
   score data=scoremyeloma out=myelomaP
         predicted lclm uclm / ilink; /* ILINK gives probabilities */
run;
proc sort data = myelomaP;
by Clair_creat CBC_MCHC ALB;
run;
/* WHEN CBC_MCHC WAS 28 AND CREATININE WAS .5 ALBUMIN DID NOT HAVE THAT MUCH OF AN EFFECT AS A PREDICTOR:
PROBABILITIES CHANGED FROM .98 TO .92 WHICH WOULD INDICATE THAT ALBUMIN DOES NOT NEED TO BE IN THE MODEL.
HOWEVER WHEN CBC_MCHC WAS 33 AND CREATININE WAS .5 ALBUMIN DID NOT HAVE THAT MUCH OF AN EFFECT AS A PREDICTOR:
PROBABILITIES CHANGED FROM .94 TO .78, WHICH WOULD INDICATE THAT ALBUMIN IS NEEDED IN THE MODEL. 
GENE RAY WANTED US TO CHECK WHAT WOULD HAPPEN WITH BINOMIAL PREDICTORS WITH THE VARIABLES INSTEAD OF QUANTITATIVE PREDICTORS
BECAUSE IT WOULD BE MUCH MORE SIMPLE FOR THE DOCTORS TO CLASSIFY THE PREDICTORS AS IN RANGE OR NOT. */
/* ALBUMIN WOULD HAVE MORE CLINICAL RELEVANCE THAN STATISTICAL SIGNIFICANCE. */

/*************************CREATING AN INTERACTION*********************/
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= CBC_MCHC clair_creat ALB CBC_MCHC*ALB Clair_creat*ALB CBC_MCHC*Clair_creat CBC_MCHC*Clair_creat*ALB; 
RUN;
QUIT;
/* DOING JUST THE TWO WAY INTERACTIONS BELOW */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= CBC_MCHC clair_creat ALB CBC_MCHC*ALB Clair_creat*ALB CBC_MCHC*Clair_creat; 
RUN;
QUIT;
/* 189 AND .648 */
/* INTERACTION IS CBC_MCHC*ALB P VALUE .3303 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB CBC_MCHC*ALB; 
RUN;
QUIT;
/* INTERACTION IS Clair_creat*ALB P VALUE .4746 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB  Clair_creat*ALB; 
RUN;
QUIT;
/* INTERACTION IS CBC_MCHC*Clair_creat P VALUE .2103 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB CBC_MCHC*Clair_creat; 
RUN;
QUIT;
/****************************************************************WINNING MODEL******************************************************/
/*MAIN EFFECTS MODEL FOR THE WIN */
/* KEEPING CREATININE AND ALBUMIN EVEN THOUGH THEY DO NOT PREDICT STAGE 3 IN THE PRESENCE OF CBC_MCHC BECAUSE THEY ARE CLINICALLY IMPORTANT. */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= CBC_MCHC clair_creat ALB; 
RUN;
QUIT;
/* FLIPPING THE ODDS RATIOS SO THAT IT IS ABOVE 1 AND EASIER TO INTERPRET
CURRENTLY AS THE CBC_MCHC DECREASES THE ODDS OF STAGE 3 WENT UP AND THE RATIO WAS UNDER 1. */

/* WE ARE CHECKING THE MIN AND MAX VALUES FOR EACH OF THE THREE PREDICTOR VARIABLES TO BE ABLE TO SELECT LOGICAL UNITS FOR INTERPRETATION
MEANING CBC_MCHC = 10 IS FOR EACH 10 UNIT DECREASE IN CBC WHAT IS THE EFFECT ON THE PREDICTION OF STAGE 3 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	class 'Multiple Myeloma Stage'n / param=reference;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= CBC_MCHC clair_creat ALB; 
	
RUN;
QUIT;
data work.myeloma5;
set work.myeloma5;
rename CBC_MCHC= MCHC;
run;
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n = MCHC clair_creat ALB; 
	
RUN;
QUIT;
/* the odds of having stage 3 increase 1.27 times for each one unit increase in CBC_MCHC */
proc means data= work.myeloma5 MEAN STD MEDIAN QRANGE MIN Q1 Q3 MAX MAXDEC= 2; 
var alb CBC_MCHC clair_creat;
run;
/* 3, 9 AND 65 DIVIDE CBC_MCHC clair_creat ALB INTO GROUPS OF 4 OVER THE RANGE OF THE DATASET */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = '0')= CBC_MCHC clair_creat ALB;
	UNITS CBC_MCHC=3 ALB=9 clair_creat=65 ; 
	store p1;  /*STORING THE PREDICTIONS RANGING FROM 0 T0 1 DISPLAYING THE CHANCE OF HAVING STAGE 3 */
RUN;
QUIT;
/***********************************************************************************************************************************/
/* SIMPLE MODEL WITH CBC_MCHC*/
/* THE ROC CURVE DID NOT LOOK GOOD ON THE LEFT SIDE AND WE DO NOT WANT TO EXPLAIN WHY IT DIPPED DOWN BLOOW THE LINE OF SPECIFICITY */

PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= MCHC; 
	UNITS MCHC=10; 
RUN;
QUIT;
/*QUESTION FOR GENE RAY: IF INTERACTION IS NOT SIGNIFICANT WHY IS ALBUMIN INCREASING OVER THE FIVE NUMBER SUMMARY CHANGE THE PREDICTOR 
A LOT WHEN CBC IS 33 BUT NOT WHEN IT WAS 28? */
/* IS IT POSSIBLY BECAUSE IT CAUSED A LOT OF MULTICOLLINEARITY BETWEEN THE OTHER TERMS? */
/*******************************************************************************************************************/
/********************************************************************************************************************/
/****************************************CATEGORICAL PROCEDURE BELOW************************************************/
/*******************************************************************************************************************/
/*******************************************************************************************************************/


/* THE FOLLOWING STEPS ARE DUPLICATING THE ABOVE PROCEDURE ON THE BINOMIAL PREDICTORS.*/

/* DR RAY INSTRUCTED ME TO CHANGE THE LEVELS OF MULTIPLE MYELOMA STAGE TO ONLY 0 AND 1
WHICH I HAVE DONE IN MY DATA CLEANING FILE WHILE ALSO KEEPING THE ORIGINAL NAMES IN THE CODE.
DR. RAY WANTED TO SEE IF WE CAN HAVE THE LEVELS BE NUMERIC VALUES SO WE CAN COUNT THEM AND PUT INTO
THE CODE BELOW */
/* ASK DR RAY HOW CAN I PROPERLY DO THIS SINCE I NOW HAVE THE BINOMAL NUMERIC LEVELS FOR EACH CATEGORICAL VARIABLE? */


proc logistic data = count;
model good1/n = dist;
run;

/* GO OVER PROC SQL WITH DR RAY!*/
/* DR RAY WANTED TO CREATE SOME AGGREGATE DATA FOR PREDICTING STAGE 3 FIRST WE 
TRIED TO INPUT THE CATEGORICAL VARIABLE WITH LEVELS NAMED BINARY12 AND BINARY3
BUT IT DID NOT WORK, MAYBE RENAMING THE LEVELS TO 0 AND 1 (0 BEING BINARY12) 
(AND 1 BEING STAGE 3 WHAT I'M MOST INTERESTED IN) SHOULD WORK? 
IF NOT SEE IF DR RAY CAN COME UP WITH A SOLUTION! */
proc SQL;
create table myelomaagg as
select CBC_MCHC,sum('Multiple Myeloma Stage'n ) as '1',count(*) as n
from work.myeloma5
group by CBC_MCHC;
quit;

/* I TRIED INPUTTING THE CATEGORICALS BELOW */
PROC LOGISTIC DATA=myelomacat
		PLOTS(ONLY)=ALL
	;
	CLASS 'ALB Category'n 'CBC_MCHC Category'n 'Clair_creat Category'n;
	MODEL 'Multiple Myeloma Stage'n (Event = '1')= 'ALB Category'n 'CBC_MCHC Category'n 'Clair_creat Category'n ;
	
	store p1; 
RUN;
QUIT;
/* AIC IS HIGHER AT 187*/
/* EVERYTHING CAME OUT TO BE INSIGNIFICANT :( */

/*************************CREATING AN INTERACTION*********************/
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB CBC_MCHC*ALB Clair_creat*ALB CBC_MCHC*Clair_creat CBC_MCHC*Clair_creat*ALB; 
RUN;
QUIT;
/* DOING JUST THE TWO WAY INTERACTIONS BELOW */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB CBC_MCHC*ALB Clair_creat*ALB CBC_MCHC*Clair_creat; 
RUN;
QUIT;
/* INTERACTION IS CBC_MCHC*ALB P VALUE .3303 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB CBC_MCHC*ALB; 
RUN;
QUIT;
/* INTERACTION IS Clair_creat*ALB P VALUE .4746 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB  Clair_creat*ALB; 
RUN;
QUIT;
/* INTERACTION IS CBC_MCHC*Clair_creat P VALUE .2103 */
PROC LOGISTIC DATA=work.myeloma5
		PLOTS(ONLY)=ALL
	;
	MODEL 'Multiple Myeloma Stage'n (Event = 'Binary3')= CBC_MCHC clair_creat ALB CBC_MCHC*Clair_creat; 
RUN;
QUIT;
/*QUESTION FOR GENE RAY: IF INTERACTION IS NOT SIGNIFICANT WHY IS ALBUMIN INCREASING OVER THE FIVE NUMBER SUMMARY CHANGE THE PREDICTOR 
A LOT WHEN CBC IS 33 BUT NOT WHEN IT WAS 28? */
/* IS IT POSSIBLY BECAUSE IT CAUSED A LOTOF MULTICOLLINEARITY BETWEEN THE OTHER TERMS? *?



