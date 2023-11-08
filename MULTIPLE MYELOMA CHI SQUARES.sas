Proc format;
Value $MyelomaformatBinary
'A'="Stage 1&2"
'B'="Stage 1&2"    
'C'="Stage 1&2"
'D'="Stage 1&2"
'E'="Stage 3"
'F'="Stage 3" ;
run;

* Step 3: Attach the format statement to the data set. ;
data work.myeloma5;
set work.myeloma4;
format 'Multiple Myeloma Stage'n MyelomaformatBinary.; /* called imbalanced data*/
run;

/**********RUNNING THIS WITH MULTIPLE MYELOMA STAGE BEING BINARY */

Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  gender*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;

Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  anemia*MARRIED / chisq nocol nocum nopercent cellchi2 expected;

run;
/********TESTING HIGH BLOOD PRESSURE *****************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables HBP*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* NOT SIGNIFICANT P VALUE .1724 */

/**************TESTING DIABETES ***********************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables diabete*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* NOT SIGNIFICANT P VALUE .7435 */

/**************TESTING TOBACCO ******************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables tobacco*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;
		
run;

Proc Freq data= WORK.MYELOMA5 order=data;
		where gender=0;
		Tables tobacco*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;
		
run;

Proc Freq data= WORK.MYELOMA5 order=data;
		where gender=1;
		Tables tobacco*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;
		
run;
/* NOT SIGNIFICANT P VALUE .7133 */

/********* Testing kappa and lambda chains **********************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  chain*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  chai*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* this comes out signiicant P VALUE .0409 */
/* EXPLAIN WHAT KAPPA AND LAMBDA LIGHT CHAINS ARE HERE AND HOW THEY RELATE TO MULTIPLE MYELOMA PATIENTS */
/* KAPPA AND LAMBDA LIGHT CHAINS ARE PROTEINS PRODUCED BY PLASMA CELLS .Light chains combine with other, longer protein 
chains, known as heavy chains, to form immunoglobulins (antibodies that play an important role in 
fighting infections).  Scientists don’t know why, but plasma cells produce more light chains than are 
needed to create immunoglobulins, and these extra light chains end up in your blood on their own as 
“free” light chains. The amount of free light chains in your blood, and the ratio of the 2 types, can help to show the 
activity of myeloma cell growth and can be used to help diagnose MULTIPLE MYELOMA. THE RESULTS FROM THIS CHI SQUARE ARE 
CLINICALLY SIGNIFICANT SINCE SYMPTOMS OF MULTIPLE MYELOMA ARE Anemia Unusual bruising or bleeding 
Bone lesions Bone pain Fatigue ETC.. WHICH IS DUE TO AN ABNORMAL AMOUNT OF FREE LIGHT CHAINS IN THE BLOOD. EXPERIENCING
THESE SYMPTOMS AHEAD OF TIME COULD BE INDICATIVE OF THIS DISEASE.
/* ALSO INCLUDE HOW THEY RELATE TO KIDNEY DISEASE*/

Proc Freq data= WORK.MYELOMA5 order=data;

		Tables  '24h_prot'n*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;

/********** Testing osteolytic lesions **********************/

proc format;
value $ostFormat
0 = 'Lesions not Present'
1 = 'Lesions are Present ';
run;
/* now I attach the formatted variable to the dataset */
Data work.myelomaost;
set work.myeloma5;
format ost_les $ostFormat.; /* this attaches the renamed levels to the original variable */
run;
Proc Freq data= WORK.MYELOMAost order=data;
		Tables  ost_les*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;

Proc Freq data= WORK.MYELOMAost order=data;
		Tables  'Multiple Myeloma Stage'n*ost_les / chisq nocol nocum nopercent cellchi2 expected;

run;



Proc Freq data= WORK.MYELOMAost order=data;
		Tables  ost_les* / chisq nocol nocum nopercent cellchi2 expected;

run;



/*Stacked Bar Chart */
/* Type is the groups within the bar */

proc sgplot data=WORK.MYELOMA5;
vbar ost_les/ group='Multiple Myeloma Stage'n;
run;
/* Origin is the groups within the bar */
proc sgplot data=SASHELP.CARS;
vbar ost/ group=ORIGIN;
run;
/* BEST CODE FOR STACKED BAR: has data labels */
proc sgplot data=WORK.MYELOMA5;
vbar ost_les/ group='Multiple Myeloma Stage'n datalabel seglabel seglabelattrs=(size=8);
run;
proc sgplot data=SASHELP.CARS;
vbar type/ group=origin datalabel seglabel seglabelattrs=(size=8);
run;

/*Pretty 100% Stacked Bar Chart--code to change the colors on the 100% stacked bar chart*/
/* ORIGIN OF CAR BY TYPE OF CAR */
/*datalabelattrs=(Color=lightgreen Family="Arial" Size=8 Style=italic Weight=bold)*/
proc freq data=WORK.MYELOMAost;
table  'Multiple Myeloma Stage'n*ost_les/out=work.freq outpct;
quit;
proc sgplot data=work.freq pctlevel=group;
vbar 'Multiple Myeloma Stage'n/
response=percent
group=ost_les
groupdisplay=stack
datalabel seglabel seglabelattrs=(size=12 color="white" weight=bold)
stat=percent
filltype=solid;
styleattrs
/* wallcolor=whitesmoke */
/* backcolor=brpk */
datacolors=("#3B8BD4" "#941D30");
title '100% Stacked Bar Chart for Presence of Osteolytic Lesions by Cancer Stage (n = 190)';
yaxis label = 'Presence of Osteolytic Lesions';
xaxis label = 'Cancer Stage';
run;









/* this comes out as significant P VALUE .0173 *******************/
/* EXPLAIN WHAT OSTEOLYTIC LESIONS ARE HERE AND HOW THEY RELATE TO MULTIPLE MYELOMA PATIENTS */
/* OSTEOLYTIC LESIONS ARE AREAS OF THE BONE DAMAGE THAT RESULT FROM THE BUILDUP OF CANCEROUS CELLS IN THE BONE MARROW
THEY MOSTLY AFFECT CANCER PATIENTS WITH MULTIPLE MYELOMA. THE RESULTS FROM THIS CHI SQUARE IS CLINICALLY FACTUAL
AS A MAJORITY OF MULTIPLE MYELOMA PATIENTS ARE PRONE TO HAVING OSTEOLYTIC LESIONS WHICH INCREASE THEIR BONE FRAGILITY
AND DECREASE THEIR BONE DENSITY. FEELING ANY SIGN OF BONE PAIN THAT GOES UNTREATED MAY INCREASE THE RISK FOR 
OSTEOLYTIC LESIONS TO DEVELOP AND THEN INCREASE THE PROGRESSION OF MULTIPLE MYELOMA, SO UNDERGOING A BONE SCAN/ XRAY 
BEFORE THE PAIN CONTINUES TO PERSIST COULD BE A WAY OF INDICATING EARLY SIGNS OF MYELOMA BEFORE IT TURNS AGGRESSIVE SO
TREATMENT COULD BE IMPLEMENTED IMMEDIATELY.

/* REAL WORLD EXAMPLE MY DAD BEFORE HIS DIAGNOSES WAS EXPERIENCING MASSIVE BONE PAIN AND INFLAMMATION OF THE LEGS */
/* AND IN MY DADS BLOOD THEY SAID THAT HE HAD HIGH LEVELS OF PROTEIN IN HIS BLOOD */
/* HE GOT A BONE SCAN */


/* MY DAD'S IRON LEVELS WERE EXTREMELY LOW LOOK UP THE NORMAL RANGE AND LOW RANGE FOR IT AND SEE IF THEIRS ANY
SIGNIFICANCE FOR IT */
/* MAKE IRON FE A CATEGORICAL BINARY 0 1 VARIABLE */ 



/***********Testing Hereditary blood disease ************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  Hrd_blo_disea*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* almost significant P VALUE .0644 BUT THE CELL COUNTS ARE EXTREMELY LOW FOR HAVING HEREDITARY BLOOD DISEASES  */

/********** RUN THIS WITH JUST THE 1 2 AND 3 MULTIPLE MYELOMA STAGES *******************/
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
format 'Multiple Myeloma Stage'n MyelomaformatA.; /* called imbalanced data*/
run;

Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  anemia*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;




Proc Freq data= WORK.MYELOMA5 order=data;

		Tables  '24h_prot'n*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;

/**********TESTING HIGH BLOOD PRESSURE **********************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables HBP*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* NOT SIGNIFICANT P VALUE = .1944 */
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables diabete*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* NOT SIGNIFICANT P VALUE = .8288 */
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables tobacco*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* NOT SIGNIFICANT P VALUE = .9109 */

/********* Testing kappa and lambda chains **********************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  chain*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* this DOESNT comes out signiicant THIS TIME P VALUE .0698*/

/********** Testing osteolytic lesions **********************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  ost_les*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* this STILL comes out as significant BUT BARELY P VALUE .0555 *******************/

/***********Testing Hereditary Blood disease ************/
Proc Freq data= WORK.MYELOMA5 order=data;
		Tables  Hrd_blo_disea*'Multiple Myeloma Stage'n / chisq nocol nocum nopercent cellchi2 expected;

run;
/* NOT SIGNIFICANT AT ALL P VALUE .1742 */





