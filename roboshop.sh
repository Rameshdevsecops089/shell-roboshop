#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f" 
SG_ID="sg-098c3eca35649f2c5" # replace with your SG_ID
INSTANCES=("mongodb" "redis" "mysql")
ZONE_ID="Z0509728XFPLN8X44IK2" # replace with your ZONE ID
DOMAIN_NAME="daws84.space" # replace with your DOMAIN Name

for instance in ${INSTANCES[@]}
do 
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-098c3eca35649f2c5 --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].PrivateIpAddress" --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0]. Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0]. Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address: $IP"
done
