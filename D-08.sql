set echo off verify off heading on feedback off

SPOOL d-08.txt
select granted_role from dba_role_privs where grantee='PUBLIC';

SPOOL OFF

