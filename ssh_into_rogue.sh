#! /bin/bash

source config.conf

instance_name="${1:-rogue}"

public_dns_name=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance_name}" --query 'Reservations[*].Instances[*].[PublicDnsName]' --output text --max-items 1)
echo "SSHing into: "$public_dns_name
ssh -i $KEY_PAIR ubuntu@"$public_dns_name"