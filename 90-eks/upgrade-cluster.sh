#!/bin/bash

#########
# Colors
#########
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#########
# Cluster Region and Name
#########
CLUSTER_NAME="roboshop-dev"
AWS_REGION="us-east-1"

EKS_TARGET_VERSION=$1

LOGS_FOLDER="/home/ec2-user/eks-upgrade"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
SCRIPT_DIR=$PWD
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/16-logs.log


mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)" | tee -a $LOG_FILE

#########
# Checking the args passed
#########
if [ "$#" -ne 1 ]; then
  echo -e "${R}Usage:${N} $0 <EKS_TARGET_VERSION>" | tee -a "$LOG_FILE"
  echo -e "${R}Example:${N} $0 1.34" | tee -a "$LOG_FILE"
  exit 1
fi


#########
# Get the addons of the cluster, we upgrade addons once control plane is upgraded
#########
ADDONS=$(aws eks list-addons --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION" --output text | awk '{print $2}')

#########
# Validate Function
#########
VALIDATE(){ # functions receive inputs through args just like shell script args
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N" | tee -a $LOG_FILE
    fi
}