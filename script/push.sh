#!/bin/bash
set -xe

PROFILE=MECA1
REGION=eu-west-3
IMAGE=commenting-isso
REPOSITORY_ID=909839560499
REPOSITORY=$REPOSITORY_ID.dkr.ecr.$REGION.amazonaws.com

cd ../
docker build -t $IMAGE .

aws --profile $PROFILE ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPOSITORY

docker tag $IMAGE:latest $REPOSITORY/$IMAGE:latest
docker push $REPOSITORY/$IMAGE:latest

task_arn=$(aws ecs list-tasks --cluster Meca1-Cluster --region $REGION | jq -r ".taskArns[]")
aws ecs stop-task --cluster Meca1-Cluster --region $REGION --task "$task_arn"
