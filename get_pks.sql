set pagesize 1000
set linesize 12
set head off
set echo off
set feedback off
set verify off

spool pk_list.txt
select TRIM(pk_rd_ws) from contexts where LAST_DAY(ADD_MONTHS(reporting_date,&&1)) < to_date((select reporting_date from scb_mlp_reportingdate), 'ddmmyyyy')
union
select TRIM(pk_rd) from contexts where LAST_DAY(ADD_MONTHS(reporting_date,&&1)) < to_date((select reporting_date from scb_mlp_reportingdate), 'ddmmyyyy')
;
spool off