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