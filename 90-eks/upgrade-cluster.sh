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