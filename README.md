# AWS Local Lambda Development

To install dependencies into the lambda function:
`pip install <package name> -t lambda/packages`

To "build" the zip archive, run `build.sh` - this creates a zip archive with all the dependencies in lambda/packages, along with lambda.py.

To run the lambda function (localstack):
`awslocal lambda invoke --function-name my_lambda output.txt --endpoint http://localhost:30000 <additional arguments as needed>`

Note that for things to work properly, some changes may be needed to Docker network settings to ensure that the containers can communicate (i.e. issues with the network name were frequent - make sure the services are on the same network for the easiest setup).

In order to use this setup with other services on Docker, make sure the corresponding contaniers are on the same network or can otherwise communicate with one another.

References:
- [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
- [https://docs.localstack.cloud/user-guide/aws/lambda/](https://docs.localstack.cloud/user-guide/aws/lambda/)
- [https://docs.aws.amazon.com/lambda/latest/dg/python-package.html](https://docs.aws.amazon.com/lambda/latest/dg/python-package.html)
