#!/bin/bash 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
source_DIR=/home/ec2-user/app-logs

if [ $USERID -ne 0 ]
then
    echo -e "$R Error:: please run this script with root access $N" | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo "you are running with root access" | tee -a $LOG_FILE
fi

# validate function takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$2 is ... $G success $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R Failure $N" | tee -a $LOG_FILE
        exit 1
    fi
}
mkdir -p $LOGS_FOLDER

echo "Script started executing at $(date)"

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath
do
    echo "Deleting file: $filepath" | tee -a $LOG_FILE
    rm -rf $filepath
done <<< $FILES_TO_DELETE

echo "script executed successfully"