#!/bin/bash

aws cloudformation describe-stack-resources --stack-name a9n | tee .lambda-resources.json
LAMBDA_NAME=$(jq -r '.StackResources[] | select(.ResourceType == "AWS::Lambda::Function") | .PhysicalResourceId' .lambda-resources.json)
echo $LAMBDA_NAME

aws lambda add-permission \
    --function-name $LAMBDA_NAME \
    --action lambda:InvokeFunction \
    --statement-id config \
    --principal config.amazonaws.com
