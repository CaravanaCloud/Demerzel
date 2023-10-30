#!/bin/sh
set -ex

aws serverlessrepo create-cloud-formation-change-set \
    --application-id arn:aws:serverlessrepo:ap-southeast-1:711761543063:applications/rdklib \
    --stack-name RDKlib-Layer | tee .change-set.json
CHANGE_SET_ARN=$(jq -r '.ChangeSetId' .change-set.json)
echo $CHANGE_SET_ARN

aws cloudformation wait change-set-create-complete --change-set-name $CHANGE_SET_ARN

aws cloudformation execute-change-set --change-set-name $CHANGE_SET_ARN

aws cloudformation wait change-set-create-complete --change-set-name $CHANGE_SET_ARN

aws cloudformation describe-stack-resources --stack-name serverlessrepo-RDKlib-Layer | tee .stack-resources.json
LAMBDA_LAYER_ARN=$(jq -r '.StackResources[0].PhysicalResourceId' .stack-resources.json)
echo $LAMBDA_LAYER_ARN

