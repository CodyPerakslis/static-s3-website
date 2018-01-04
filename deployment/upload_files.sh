#!/bin/bash

. ./deployment/load_variables.sh

aws s3 cp ./$WebTarget/ s3://$HeadBucket/ --recursive
