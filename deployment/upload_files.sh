#!/bin/bash

. ./deployment/load_variables.sh

aws s3 cp $websitedirectory/ s3://$headbucket/ --recursive
