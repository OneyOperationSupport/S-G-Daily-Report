DATA WORK.DPS_DAILYAPPLY_INFO&day.;SET WORK.DPS_APPLY_INFO&day.;
%datechange(APPLYDATE);%datechange(APPROVETIME); %datechange(FINISHDATE);%datechange(INPUTDATE);
INPUT_Duration = APPLYDATE_Update - INPUTDATE_Update;format INPUT_Duration time8.; /*录入时间*/
UNDERWRTING_Duration = APPROVETIME_Update - APPLYDATE_Update;format UNDERWRTING_Duration time8.;/*审批时间*/
TOTAL_Duration = FINISHDATE_Update-INPUTDATE_Update;format TOTAL_Duration time8.;/*整个时长*/
WEEKDAY= weekday(Date_Update);
Apply_YearMonth= substr(APPLYDATE,1,10);
Apply_Time=substr(APPLYDATE,11,8);
date=input(applydate,yymmdd10.);
Today=input(left(put("&sysdate"d,yymmdd10.)),yymmdd10.);
if date=today-1 /*or date = today-2 or date = today-3 then output*/;
run;



PROC SQL;
   CREATE TABLE  result AS 
   SELECT  
FULLNAME,
APPLYCODE,
INPUTDATE,
Apply_YearMonth,
Apply_Time,
INPUT_Duration,
UNDERWRTING_Duration,
TOTAL_Duration,
WEEKDAY,
INPUTER,
CONTRACTOPER,
SIGNCONTRACT,
DEFPHASES,
STATUS,
APPROVER,
POSCODE,
POSNAME,
PROCFEE,
SERVICEFEE,
SUPPORTFEE, 
TOTALDEFPRICE,
TOTALPRICE
FROM WORK.DPS_DAILYAPPLY_INFO&day.;
QUIT;
;run;

proc print data=result;
title "SIGN & GO Daily Report";
run;
