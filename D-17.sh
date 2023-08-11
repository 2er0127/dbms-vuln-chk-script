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

echo "[D-17] 2.7 데이터베이스의 주요 설정파일, 패스워드 파일 등과 같은 주요 파일들의 접근 권한이 적절하게 설정" >> $result_filename 2>&1
echo "[양호] 주요 설정 파일 및 디렉터리의 퍼미션 설정 시 일반 사용자의 수정 권한을 제거한 경우" >> $result_filename 2>&1
echo "[취약] 주요 설정 파일 및 디렉터리의 퍼미션 설정 시 일반 사용자의 수정 권한을 제거하지 않은 경우" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1
echo "=======================진단 결과=======================" >> $result_filename 2>&1

touch d-17list.txt

ls -al /app/oracle/oradata/david/* >> d-17list.txt
ls -al /app/oracle/recovery_area/david/* >> d-17list.txt
ls -al /app/oracle/dbs/dbs/* >> d-17list.txt

FILENAME=d-17list.txt
PERMCHECK1=$(find $FILENAME -perm 666)
PERMCHECK2=$(find $FILENAME -perm 663)
PERMCHECK3=$(find $FILENAME -perm 662)
PERMCHECK4=$(find $FILENAME -perm 646)
PERMCHECK5=$(find $FILENAME -perm 643)
PERMCHECK6=$(find $FILENAME -perm 642)

cat $FILENAME | while read line
do
	if [ -n $PERMCHECK1 ] || [ -n $PERMCHECK2 ] || [ -n $PERMCHECK3 ] || [ -n $PERMCHECK4 ] || [ -n $PERMCHECK5 ] || [ -n $PERMCHECK6 ]
		then
			echo "[양호] "$line" 파일의 일반 사용자의 수정 권한이 제거되어 있습니다." >> $result_filename 2>&1
		else
			echo "[취약] "$line" 파일의 일반 사용자의 수정 권한이 제거되어 있지 않습니다." >> $result_filename 2>&1
	fi
done

echo " " >> $result_filename 2>&1

