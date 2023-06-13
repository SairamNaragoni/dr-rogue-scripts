#! /bin/bash

source config.conf

instance_name=${1:-"rogue"}
instance_type=${1:-"g4dn.4xlarge"}

aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type $instance_type \
--key-name $KEY_PAIR --security-group-ids $SECURITY_GROUP_ID --subnet-id $SUBNET_ID \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=\"$instance_name\"}]"  \
--iam-instance-profile Name=$IAM_ROLE \

./update_sec_group.sh

