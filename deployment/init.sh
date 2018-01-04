#!/bin/bash
set -e
. ./deployment/load_variables.sh

echo "Opening ${HeadBucket} ..."

function hosting {
  echo "Enable hosting ..."
  aws s3 website s3://$HeadBucket/ \
    --index-document index.html \
    --error-document error.html
}

function publicify {
  echo "Making public ..."
  cp ./deployment/publicpolicy.json /tmp/publicpolicy.json
  sed -i "s/MYBUCKET/${HeadBucket}/g" /tmp/publicpolicy.json

  aws s3api put-bucket-policy \
    --bucket $HeadBucket \
    --policy file:///tmp/publicpolicy.json

  rm /tmp/publicpolicy.json
}

function s3-create {
  echo "Creating ${HeadBucket} bucket ..."
  aws s3api wait bucket-not-exists --bucket $HeadBucket
  aws s3api create-bucket --bucket $HeadBucket --region us-east-1 1> /dev/null
  hosting
  publicify
  echo "Done."
}

trap s3-create EXIT
aws s3api head-bucket --bucket $HeadBucket 2> /dev/null
trap - EXIT

hosting
publicify
echo "Done."
