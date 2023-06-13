#!/bin/bash

base_path=$HOME/deepracer-for-cloud
source deepracer-for-cloud/system.env

robomaker_version=$DR_ROBOMAKER_IMAGE
sagemaker_version=$DR_SAGEMAKER_IMAGE
rl_coach=$DR_COACH_IMAGE

curr_robomaker_version=$(docker images awsdeepracercommunity/deepracer-robomaker | tail -n +2 | awk '{print $2}')
curr_sagemaker_version=$(docker images awsdeepracercommunity/deepracer-sagemaker | tail -n +2 | awk '{print $2}')
curr_rlcoach_version=$(docker images awsdeepracercommunity/deepracer-rlcoach | tail -n +2 | awk '{print $2}')

if [ "$curr_robomaker_version" != $robomaker_version ]
then
	echo "Robomaker version is not the same"
	robomaker_image_id=$(docker images -q awsdeepracercommunity/deepracer-robomaker)
	docker image rm $robomaker_image_id
	docker pull awsdeepracercommunity/deepracer-robomaker:${robomaker_version}
	#sed -i "s/DR_ROBOMAKER_IMAGE=.*/DR_ROBOMAKER_IMAGE=$robomaker_version/" $base_path/system.env
fi

if [ "$curr_sagemaker_version" != $sagemaker_version ]
then
	echo "Sagemaker version is not the same"
	sagemaker_image_id=$(docker images -q awsdeepracercommunity/deepracer-sagemaker)
	docker image rm $sagemaker_image_id
	docker pull awsdeepracercommunity/deepracer-sagemaker:${sagemaker_version}
	#sed -i "s/DR_SAGEMAKER_IMAGE=.*/DR_SAGEMAKER_IMAGE=$sagemaker_version/" $base_path/system.env
fi

if [ "$curr_rlcoach_version" != $rl_coach ]
then
	echo "Rlcoach version is not the same"
	rl_coach_image_id=$(docker images -q awsdeepracercommunity/deepracer-rlcoach)
	docker image rm $rl_coach_image_id
	docker pull awsdeepracercommunity/deepracer-rlcoach:${rl_coach}
	#sed -i "s/DR_COACH_IMAGE=.*/DR_COACH_IMAGE=$rl_coach/" $base_path/system.env
fi

echo "Updated docker images"
docker images

cat $base_path/system.env
dr-update