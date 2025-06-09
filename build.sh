#!/bin/sh

cd lambda/packages

zip -r ../function.zip .

cd ../

zip function.zip lambda.py

cd ../

mv lambda/function.zip ./function.zip
