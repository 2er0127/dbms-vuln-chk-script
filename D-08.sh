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

echo "[D-08] 3.1 응용 프로그램 또는 DBA 계정의 Role이 Public으로 설정되지 않도록 설정" >> $result_filename 2>&1
echo "[양호] DBA 계정의 Role이 Public으로 설정되어있지 않은 경우" >> $result_filename 2>&1
echo "[취약] DBA 계정의 Role이 Public으로 설정되어있는 경우" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1
echo "=======================진단 결과=======================" >> $result_filename 2>&1

FILE=`sqlplus -s '/as sysdba'<<EOF 
	set colsep '.' feedback off verify off echo off 
	set heading on 
	@d-08.sql
	exit;
EOF`

FILESIZE=$(wc -c d-08.txt | awk '{print $1}')

if [ $FILESIZE -gt 0 ]
	then
		echo "[취약] DBA 계정의 Role이 Public으로 설정되어 있습니다." >> $result_filename 2>&1
	else
		echo "[양호] DBA 계정의 Role이 Public으로 설정되어 있지 않습니다." >> $result_filename 2>&1
fi

echo " " >> $result_filename 2>&1

