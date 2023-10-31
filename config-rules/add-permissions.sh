#!/bin/bash

aws cloudformation describe-stack-resources --stack-name a9n | tee .lambda-resources.json
LAMBDA_NAME=$(jq -r '.StackResources[] | select(.ResourceType == "AWS::Lambda::Function") | .PhysicalResourceId' .lambda-resources.json)
echo $LAMBDA_NAME

aws lambda add-permission \
    --function-name $LAMBDA_NAME \
    --action lambda:InvokeFunction \
    --statement-id config \
    --principal config.amazonaws.com

ROLE_NAME=$(jq -r '.StackResources[] | select(.ResourceType == "AWS::IAM::Role") | .PhysicalResourceId' .lambda-resources.json)
echo $ROLE_NAME

RDK_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo $RDK_ACCOUNT_ID

envsubst < trust-policy.env.json > .trust-policy.json
cat .trust-policy.json

A9N_ROLE_NAME="${ROLE_NAME}_a9n_role"
echo $A9N_ROLE_NAME

aws iam create-role \
  --role-name $A9N_ROLE_NAME \
  --assume-role-policy-document file://.trust-policy.json \
  --description "Role with AWS_ConfigRole managed policy and trust relationship with AWS Config and /rdk/ path roles" | tee .a9n-role.json

aws iam attach-role-policy \
    --role-name "$A9N_ROLE_NAME" \
    --policy-arn "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"


