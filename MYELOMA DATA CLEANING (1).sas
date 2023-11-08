
%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u63058532/Directed studies Research/MM-DataSet csv.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.myeloma;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.myeloma; RUN;


%web_open_table(WORK.myeloma);

/* to check for missing values and generate the tables */
/* example code */
proc freq data=work.myeloma;
run;

DATA WORK.myeloma2; /* generate the sas data set from your work library can be any name */
	SET work.myeloma; /* set the dataset from the sas help library */
	keep Wilaya Gender Married Blood HBP Diabete Tobacco Chron_disea Hrd_blo_disea 'asth&bone'n Anemia Roll_RBC CRP '24h_prot'n
Bjp
Ig
Chain
Ost_les
Ac_Anti_HCV
HIV
Ag_HBS
Class
; /* this keeps the variables that you need in the data*/
RUN;

/* to check for missing values and generate the tables */
/* example code */
proc freq data=work.myeloma2;
tables Wilaya Gender Married Blood HBP Diabete Tobacco Chron_disea Hrd_blo_disea 'Asth&bone'n Anemia Roll_RBC CRP '24h_prot'n
Bjp
Ig
Chain
Ost_les
Ac_Anti_HCV
HIV
Ag_HBS
Class ;
run;
/* have to convert the  36 quantitative variables into the numeric type!
*/
/*body_Surf*/
data work.myeloma3;
set work.myeloma(rename=(body_surf=old));
body_surf = input(old,bodysurf3.);
drop old;
run;
/*creat*/
data work.myeloma3;
set work.myeloma3(rename=(creat=old));
creat = input(old,creat3.);
drop old;
run;
/*nbrs_child*/
data work.myeloma3;
set work.myeloma3(rename=(nbrs_child=old));
nbrs_child = input(old,nbrs_child3.);
drop old;
run;
/*CBC_WBC*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_WBC=old));
CBC_WBC = input(old,CBC_WBC3.);
drop old;
run;
/*CBC_RBC*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_RBC=old));
CBC_RBC = input(old,CBC_RBC3.);
drop old;
run;
/*CBC_plats*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_plats=old));
CBC_plats= input(old,CBC_plats3.);
drop old;
run;
/*CBC_Hgb*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_Hgb=old));
CBC_Hgb= input(old,CBC_Hgb3.);
drop old;
run;
/*CBC_Hct*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_Hct=old));
CBC_Hct= input(old,CBC_Hct3.);
drop old;
run;
/*CBC_MCV*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_MCV=old));
CBC_MCV= input(old,CBC_MCV3.);
drop old;
run;
/*CBC_MCHC*/
data work.myeloma3;
set work.myeloma3(rename=(CBC_MCHC=old));
CBC_MCHC= input(old,CBC_MCHC3.);
drop old;
run;
/*VS*/
data work.myeloma3;
set work.myeloma3(rename=(VS=old));
VS= input(old,VS3.);
drop old;
run;
/*Plasma_cells*/
data work.myeloma3;
set work.myeloma3(rename=(Plasma_cells=old));
Plasma_cells= input(old,Plasma_cells3.);
drop old;
run;
/*Ca*/
data work.myeloma3;
set work.myeloma3(rename=(Ca=old));
Ca= input(old,Ca3.);
drop old;
run;
/*K*/
data work.myeloma3;
set work.myeloma3(rename=(K=old));
K= input(old,K3.);
drop old;
run;
/*P*/
data work.myeloma3;
set work.myeloma3(rename=(P=old));
P= input(old,P3.);
drop old;
run;
/*Na*/
data work.myeloma3;
set work.myeloma3(rename=(Na=old));
Na= input(old,Na3.);
drop old;
run;
/*B2M*/
data work.myeloma3;
set work.myeloma3(rename=(B2M=old));
B2M= input(old,B2M3.);
drop old;
run;
/*Urea*/
data work.myeloma3;
set work.myeloma3(rename=(Urea=old));
Urea= input(old,Urea3.);
drop old;
run;
/*Clair_creat*/
data work.myeloma3;
set work.myeloma3(rename=(Clair_creat=old));
Clair_creat= input(old,Clair_creat3.);
drop old;
run;
/*Alb*/
data work.myeloma3;
set work.myeloma3(rename=(Alb=old));
Alb= input(old,Alb3.);
drop old;
run;
/*a_glob*/
data work.myeloma3;
set work.myeloma3(rename=(a_glob=old));
a_glob= input(old,a_glob3.);
drop old;
run;
/*b_glob*/
data work.myeloma3;
set work.myeloma3(rename=(b_glob=old));
b_glob= input(old,b_glob3.);
drop old;
run;
/*g_glob*/
data work.myeloma3;
set work.myeloma3(rename=(g_glob=old));
g_glob= input(old,g_glob3.);
drop old;
run;
/*Prot_rate*/
data work.myeloma3;
set work.myeloma3(rename=(Prot_rate=old));
Prot_rate= input(old,Prot_rate3.);
drop old;
run;
/*SGOT*/
data work.myeloma3;
set work.myeloma3(rename=(SGOT=old));
SGOT= input(old,SGOT3.);
drop old;
run;
/*SGPT*/
data work.myeloma3;
set work.myeloma3(rename=(SGPT=old));
SGPT= input(old,SGPT3.);
drop old;
run;
/*GGT*/
data work.myeloma3;
set work.myeloma3(rename=(GGT=old));
GGT= input(old,GGT3.);
drop old;
run;
/*PAL*/
data work.myeloma3;
set work.myeloma3(rename=(PAL=old));
PAL= input(old,PAL3.);
drop old;
run;
/*Gly*/
data work.myeloma3;
set work.myeloma3(rename=(Gly=old));
Gly= input(old,Gly3.);
drop old;
run;
/*TCA*/
data work.myeloma3;
set work.myeloma3(rename=(TCA=old));
TCA= input(old,TCA3.);
drop old;
run;
/*TP*/
data work.myeloma3;
set work.myeloma3(rename=(TP=old));
TP= input(old,TP3.);
drop old;
run;
/*FIB*/
data work.myeloma3;
set work.myeloma3(rename=(FIB=old));
FIB= input(old,FIB3.);
drop old;
run;
/*Ferr*/
data work.myeloma3;
set work.myeloma3(rename=(Ferr=old));
Ferr= input(old,Ferr3.);
drop old;
run;
/*FE*/
data work.myeloma3;
set work.myeloma3(rename=(FE=old));
FE= input(old,FE3.);
drop old;
run;
/*LDH*/
data work.myeloma3;
set work.myeloma3(rename=(LDH=old));
LDH= input(old,LDH3.);
drop old;
run;
/*Weight*/
data work.myeloma3;
set work.myeloma3(rename=(Weight=old));
Weight= input(old,Weight3.);
drop old;
run;
data work.myeloma3;
set work.myeloma3;
rename weight='Weight(kg)'n ;
run;






data work.myeloma3;
set work.myeloma3;
if Wilaya = "?" then Wilaya = " ";
if Gender = "?" then gender = " ";
if Married = "?" then married = " ";
if Blood = "?" then blood = " ";
if HBP = "?" then HBP = " ";
if Diabete = "?" then Diabete = " ";
if Tobacco  = "?" then Tobacco = " ";
if Chron_disea = "?" then Chron_disea = " ";
if Hrd_blo_disea = "?" then Hrd_blo_disea = " ";
if 'asth&bone'n = "?" then 'asth&bone'n = " ";
if Anemia = "?" then anemia =" ";
if Roll_RBC = "?" then Roll_RBC = " ";
if CRP = "?" then CRP = " ";
if '24h_prot'n = "?" then '24h_prot'n = " ";
if Bjp = "?" then Bjp = " ";
if Ig = "?" then Ig = " ";
if Chain = "?" then chain = " ";
if Ost_les = "?" then Ost_les = " ";
if Ac_Anti_HCV = "?" then Ac_Anti_HCV = " ";
if HIV = "?" then HIV = " ";
if Ag_HBS = "?" then Ag_HBS = " ";
run;







data work.myeloma4;
set work.myeloma3;
 	if  class = 2 then 'Multiple Myeloma Stage'n='A';
	else if class = 3  then 'Multiple Myeloma Stage'n='B';
	else if class = 4 then 'Multiple Myeloma Stage'n='C';
	else if class = 5 then 'Multiple Myeloma Stage'n='D';
	else if class = 6 then 'Multiple Myeloma Stage'n='E';
	else if class = 7 then 'Multiple Myeloma Stage'n='F';
	else delete;
RUN;
* Step 2: Create the format equivalents you want for A, B, C. They can have spaces in the formats. ;
Proc format;
Value $Myelomaformat
'A'="Stage 1A"
'B'="Stage 1B"     
'C'="Stage 2A"
'D'="Stage 2B"
'E'="Stage 3A"
'F'="Stage 3B" ;
Value $MyelomaformatA
'A'="Stage 1"
'B'="Stage 1"     
'C'="Stage 2"
'D'="Stage 2"
'E'="Stage 3"
'F'="Stage 3" ;

Value $MyelomaformatBinary
'A'=0
'B'=0     
'C'=0
'D'=0
'E'=1
'F'=1 ;
run;

* Step 3: Attach the format statement to the data set. ;
data work.myeloma5;
set work.myeloma4;
format 'Multiple Myeloma Stage'n MyelomaformatBinary.; /* called imbalanced data*/
run;

proc freq data= WORK.MYELOMA5;
tables 'Multiple Myeloma Stage'n;
run;

Data myelomanomiss;
set work.myeloma5;
    if cmiss(of CBC_MCHC alb Clair_creat) then delete;
run;
data work.myelomacat;
set myelomanomiss;
length 'Clair_creat Category'n $25; /* make sure to add $20 to ensure the length of the variable!*/
 	if Clair_creat <67 then 'Clair_creat Category'n='A';
	else if 67<= Clair_creat <145 then 'Clair_creat Category'n='B';
	else if Clair_creat >145 then 'Clair_creat Category'n='B';
RUN;
* Step 2: Create the format equivalents you want for A, B, C. They can have spaces in the formats. ;
Proc format;
Value $clairformat
'A'="Myeloma Indicator"
'B'="Normal/High"      ;
Value $clairformatBinary
'A'=1
'B'=0      ;
run;

* Step 3: Attach the format statement to the data set. ;
data work.myelomacat;
set work.myelomacat;
format 'Clair_creat Category'n clairformatBINARY.;
run;

proc freq data= myelomacat;
tables 'Clair_creat Category'n;
run;
/* only two values for the high category are shown. maybe only do two levels with a low and normal range category?*/
/*ranges gathered from mayoclinic on creatinine levels */
/*CBC_MCHC  <32 g/dl low 32<= to 36<= normal 36> high*/
data work.myelomacat;
set work.myelomacat;
length 'CBC_MCHC Category'n $25; /* make sure to add $20 to ensure the length of the variable!*/
 	if CBC_MCHC <32 then 'CBC_MCHC Category'n='A';
	else if 32<= CBC_MCHC <36 then 'CBC_MCHC Category'n='B';
	else if CBC_MCHC >36 then 'CBC_MCHC Category'n='B';
RUN;
* Step 2: Create the format equivalents you want for A, B, C. They can have spaces in the formats. ;
Proc format;
Value $CBC_MCHCformat
'A'="Myeloma Indicator" /*myeloma defining event */
'B'="Normal/High" ;
Value $CBC_MCHCformatBinary
'A'=1
'B'=0 ;
run;

* Step 3: Attach the format statement to the data set. ;
data work.myelomacat;
set work.myelomacat;
format 'CBC_MCHC Category'n CBC_MCHCformatBINARY.;
run;

proc freq data= myelomacat;
tables 'CBC_MCHC Category'n;
run;

/* ALB  <34 low 34 to 55 normal 55> high */
data work.myelomacat;
set work.myelomacat;
length 'ALB Category'n $25; /* make sure to add $20 to ensure the length of the variable!*/
 	if ALB  <34 then 'ALB Category'n='A';
	else if 34<= ALB  <55 then 'ALB Category'n='B';
	else if ALB  >55 then 'ALB Category'n='B';
RUN;
* Step 2: Create the format equivalents you want for A, B, C. They can have spaces in the formats. ;
Proc format;
Value $ALBformat
'A'="Myeloma Indicator"
'B'="Normal/High" ;
Value $ALBformatBINARY
'A'=1
'B'=0 ;
run;

* Step 3: Attach the format statement to the data set. ;
data work.myelomacat;
set work.myelomacat;
format 'ALB Category'n ALBformatBINARY.;
run;

proc freq data= work.myelomacat;
tables 'ALB Category'n;
run;
/*only two albumin levels within the range gathered from ucsfhealth.org so maybe only use two levels */
proc freq data= work.myelomacat;
tables 'ALB Category'n 'CBC_MCHC Category'n 'Clair_creat Category'n ;
run;