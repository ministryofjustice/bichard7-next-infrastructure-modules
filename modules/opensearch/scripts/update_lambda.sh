#!/usr/bin/env bash

pip3 install --target ./compiled_function -r ./functions/requirements.txt
cp ./functions/snapshot.py ./compiled_function/snapshot.py
cd compiled_function
zip -r ../snapshot_lambda.zip .
cd ../
rm -rf compiled_function
