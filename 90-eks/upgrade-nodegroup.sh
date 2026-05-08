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


CONFIRM(){
  echo -e "${Y}$1${N}" | tee -a "$LOG_FILE"
  read -p "Type YES to continue: " ANS
  if [[ "$ANS" != "YES" ]]; then
    echo -e "${R}Aborted by user${N}" | tee -a "$LOG_FILE"
    exit 1
  fi
}

# ---- Args validation (keep only once)
if [[ $# -ne 1 ]]; then
  echo -e "${R}Usage:${N} $0 <CURRENT_NG_VERSION>" | tee -a "$LOG_FILE"
  echo -e "${R}Example:${N} $0 green" | tee -a "$LOG_FILE"
  exit 1
fi

if [[ "$CURRENT_NG_VERSION" != "blue" && "$CURRENT_NG_VERSION" != "green" ]]; then
  echo -e "${R}CURRENT_NG_VERSION must be either 'blue' or 'green'${N}" | tee -a "$LOG_FILE"
  exit 1
fi



if [[ "$CURRENT_NG_VERSION" == "blue" ]]; then
  TARGET_NG_VERSION="green"
else
  TARGET_NG_VERSION="blue"
fi

echo -e "${Y}Current nodegroup: $CURRENT_NG_VERSION${N}" | tee -a "$LOG_FILE"
echo -e "${Y}Target  nodegroup: $TARGET_NG_VERSION${N}" | tee -a "$LOG_FILE"


# --- Get current control plane version
CP_VERSION=$(aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.version' \
  --output text)
VALIDATE $? "Fetch current control plane version"
echo -e "${Y}Control plane version: $CP_VERSION${N}" | tee -a "$LOG_FILE"


# --- Detect current nodegroup kubelet minor version
KUBELET_VER=$(kubectl get nodes -l "nodegroup=${CURRENT_NG_VERSION}" \
  -o jsonpath='{.items[0].status.nodeInfo.kubeletVersion}' 2>/dev/null)

if [[ -z "$KUBELET_VER" ]]; then
  echo -e "${R}No nodes found with label nodegroup=${CURRENT_NG_VERSION}. Check node labels.${N}" | tee -a "$LOG_FILE"
  exit 1
fi