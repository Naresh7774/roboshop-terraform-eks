#!/bin/bash

##### Colors ####
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CLUSTER_NAME="roboshop-dev"
AWS_REGION="us-east-1"

CURRENT_NG_VERSION="$1"  # blue|green
TARGET_NG_VERSION=""

LOGS_FOLDER="/home/ec2-user/eks-upgrade"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"


mkdir -p "$LOGS_FOLDER"
echo "Script started executed at: $(date)" | tee -a "$LOG_FILE"

VALIDATE(){
  if [ $1 -ne 0 ]; then
    echo -e "$2 ... $R FAILURE $N" | tee -a "$LOG_FILE"
    exit 1
  else
    echo -e "$2 ... $G SUCCESS $N" | tee -a "$LOG_FILE"
  fi
}