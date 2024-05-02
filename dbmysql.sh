#!/bin/bash

source ./common.sh

check_root

echo "Please enter DB password:"
read mysql_root_password

dnf install mysql-server -y &>>$LOGFILE

systemctl enable mysqld &>>$LOGFILE

systemctl start mysqld &>>$LOGFILE

# Below code is Idempotency nature(run multiple times same output)

 mysql -h dbsql.nirmaladevops.cloud -uroot -p${mysql_root_password} -e 'show databases;'

if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
   
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi



