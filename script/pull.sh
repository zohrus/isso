#!/bin/bash
set -xe

PROFILE=MECA1
REGION=eu-west-3
IMAGE=commenting-isso
REPOSITORY_ID=909839560499
REPOSITORY=$REPOSITORY_ID.dkr.ecr.$REGION.amazonaws.com

aws --profile $PROFILE ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPOSITORY

docker pull $REPOSITORY/$IMAGE:latest
