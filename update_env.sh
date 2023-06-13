#! /bin/bash

source config.conf

instance_name="${1:-rogue}"
cf_dir="${2:-custom_files}"

[ ! -d $cf_dir ] && mkdir $cf_dir

aws s3 sync $S3_BASE_URI/$cf_dir/ $cf_dir

public_dns_name=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance_name}" --query 'Reservations[*].Instances[*].[PublicDnsName]' --output text | tr -d '\n')

scp -i $KEY_PAIR.pem update_images.sh ubuntu@"$public_dns_name":/home/ubuntu/update_images.sh
scp -i $KEY_PAIR.pem $cf_dir/run.env ubuntu@"$public_dns_name":/home/ubuntu/deepracer-for-cloud/
scp -i $KEY_PAIR.pem $cf_dir/system.env ubuntu@"$public_dns_name":/home/ubuntu/deepracer-for-cloud/

./ssh_into_rogue.sh $instance_name