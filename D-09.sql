set echo off verify off heading on feedback off

SPOOL d-09.txt
select name||':'||value from v$parameter where name='os_roles' or name='remote_os_authent' or name='remote_os_roles';

SPOOL OFF

