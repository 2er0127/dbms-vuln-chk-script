#!/bin/sh

LANG=C
export LANG
alias ls=ls

#oracle process check
ps -ef | grep pmon

#$oracle_home default,input 
result_filename=`hostname`'_ORACLE'.txt

echo "====================================================" >> $result_filename 2>&1
echo "*               DBMS_script version0.1             *" >> $result_filename 2>&1
echo "====================================================" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1
echo "---------------------start time---------------------" >> $result_filename 2>&1
date >> $result_filename 2>&1
echo "----------------------------------------------------" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1

echo "####################################################" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1

echo "[D-09] 3.2 OS_ROLES, REMOTE_OS_AUTHENTICATION, REMOTE_OS_ROLES를 FALSE로 설정" >> $result_filename 2>&1
echo "[양호] OS_ROLES, REMOTE_OS_AUTHENTICATION, REMOTE_OS_ROLES 설정이 FALSE로 되어있는 경우" >> $result_filename 2>&1
echo "[취약] OS_ROLES, REMOTE_OS_AUTHENTICATION, REMOTE_OS_ROLES 설정이 TRUE로 되어있는 경우" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1
echo "=======================진단 결과=======================" >> $result_filename 2>&1

FILE=`sqlplus -s '/as sysdba'<<EOF 
	set colsep '.' feedback off verify off echo off 
	set heading on 
	@d-09.sql
	exit;
EOF`

OSROLES=$(cat d-09.txt | grep "^os_roles" | grep FALSE)
REMOTEOSAUTH=$(cat d-09.txt | grep "^remote_os_authent" | grep FALSE)
REMOTEOSROLES=$(cat d-09.txt | grep "^remote_os_roles" | grep FALSE)

if [ $OSROLES ] && [ $REMOTEOSAUTH ] && [ $REMOTEOSROLES ]
	then
		echo "[양호] 파일 설정이 모두 FALSE로 되어 있습니다." >> $result_filename 2>&1
	else
		echo "[취약] 파일 설정이 TRUE로 되어 있습니다. 파일을 확인해주세요." >> $result_filename 2>&1
		echo `cat d-09.txt` >> $result_filename 2>&1
fi

echo " " >> $result_filename 2>&1

