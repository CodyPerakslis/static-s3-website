#!/bin/bash

. ./deployment/load_variables.sh

aws s3 cp ./website/ s3://$HeadBucket/ --recursive
