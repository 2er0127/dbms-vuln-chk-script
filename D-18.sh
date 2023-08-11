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

echo "[D-18] 2.8 관리자 이외의 사용자가 오라클 리스너의 접속을 통해 리스너 로그 및 trace 파일에 대한 변경 제한" >> $result_filename 2>&1
echo "[양호] 리스너 관련 설정 파일에 대한 퍼미션이 관리자로 설정되어 있으며, 리스너로 파라미터를 변경할 수 없게 옵션을 설정했을 경우" >> $result_filename 2>&1
echo "[취약] 리스너 관련 설정 파일에 대한 퍼미션이 일반 사용자로 설정되어 있고, 리스너로 파라미터를 변경할 수 없게 옵션 설정을 하지 않았을 경우" >> $result_filename 2>&1
echo " " >> $result_filename 2>&1
echo "=======================진단 결과=======================" >> $result_filename 2>&1

TMPFILE=$(mktemp)

FILE=$(ls -al /app/oracle/dbs/network/admin/listener.ora | awk '{print $3}')
echo `cat /app/oracle/dbs/network/admin/listener.ora | grep ADMIN_RESTRICTIONS_ListenerName | grep on` >> $TMPFILE 2>&1
FILESIZE=$(wc -c "$TMPFILE" | awk '{print $1}')

if [ $FILE == 'root' ]
	then 
		echo "파일이 관리자로 설정되어 있습니다." >> $result_filename 2>&1
		if [ $FILESIZE -gt 1 ]
			then
				echo "[양호] 옵션 설정이 되어 있습니다." >> $result_filename 2>&1
			else
				echo "[취약] 옵션 설정을 하지 않았습니다." >> $result_filename 2>&1
		fi
	else
		echo "[취약] 파일이 관리자로 설정되어 있지 않습니다." >> $result_filename 2>&1
fi

echo " " >> $result_filename 2>&1

