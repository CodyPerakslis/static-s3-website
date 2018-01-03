#!/bin/bash

# Load variables
. ./deployment/load_variables.sh


# Upload cloudformation template to s3
aws s3 cp deployment/$deployfile s3://$bucket/$keypostfix

# Run cloudformation
function already-exists {
  aws cloudformation update-stack \
    --template-url $root/$bucket/$keypostfix \
    --stack-name $stackname \
    --parameters "[{\"ParameterKey\":\"HeadBucket\",\"ParameterValue\":\"${headbucket}\"},{\"ParameterKey\":\"RedirectBucket\",\"ParameterValue\":\"${redirectbucket}\"}]"
}

function create-stack {
  aws cloudformation create-stack \
    --template-url $root/$bucket/$keypostfix \
    --stack-name $stackname \
    --parameters "[{\"ParameterKey\":\"HeadBucket\",\"ParameterValue\":\"${headbucket}\"},{\"ParameterKey\":\"RedirectBucket\",\"ParameterValue\":\"${redirectbucket}\"}]"
}

#set -e
#trap already-exists EXIT
create-stack

#trap - EXIT
