```
{'internalErrorMessage': 'Insufficient access to perform this action.', 
'internalErrorDetails': 'An error occurred (AccessDenied) when calling the AssumeRole operation: User: arn:aws:sts::053081517504:assumed-role/a9n-rdkLambdaRole-NKKL1RhEaTZy/RDK-Rule-Function-a9n is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::053081517504:role/aws-service-role/config.amazonaws.com/AWSServiceRoleForConfig', 'customerErrorMessage': 'AWS Config does not have permission to assume the IAM role. Please try 1) grant the right privilege to the assume the IAM role OR 2) provide Config Rules parameter "EXECUTION_ROLE_NAME" to specify a role to execute your rule OR 3)Set Config Rules parameter "ASSUME_ROLE_MODE" to False to use your lambda role instead of default Config Role.', 'customerErrorCode': 'AccessDenied'}
    ```
    # use AWS CLI to allow ts:AsssumeRole on AWSServiceRoleForConfig to role RDK-Rule-Function-a9n
