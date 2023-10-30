#!/bin/bash

LAMBDA_LAYER_ARN=$(jq -r '.StackResources[0].PhysicalResourceId' .stack-resources.json)
echo $LAMBDA_LAYER_ARN

rdk deploy a9n --rdklib-layer-arn $LAMBDA_LAYER_ARN
