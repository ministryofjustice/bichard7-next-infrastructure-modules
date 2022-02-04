#!/usr/bin/env bash

rm snapshot_lambda.zip || true
rm -rf ./compiled_function || true
pip3 install --upgrade --target ./compiled_function -r ./functions/requirements.txt
cp ./functions/snapshot.py ./compiled_function/snapshot.py
cd ./compiled_function
zip -r ../snapshot_lambda.zip .
rm -rf ./compiled_function

echo "Lambda payload created please upload to s3"
