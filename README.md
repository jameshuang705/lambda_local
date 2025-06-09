# AWS Local Lambda Development

To install dependencies into the lambda function:
`pip install <package name> -t lambda/packages`

To "build" the zip archive, run `build.sh` - this creates a zip archive with all the dependencies in lambda/packages, along with lambda.py.

To run the lambda function (localstack):
`awslocal lambda invoke --function-name my_lambda output.txt --endpoint http://localhost:30000 <additional arguments as needed>`

Note that for things to work properly, some changes may be needed to Docker network settings to ensure that the containers can communicate (i.e. issues with the network name were frequent - make sure the services are on the same network for the easiest setup).

In order to use this setup with other services on Docker, make sure the corresponding contaniers are on the same network or can otherwise communicate with one another. In this setup, the resulting container for the lambda handler which is started up by localstack will not be able to communicate with external services (e.g. `curl` to a public website will fail).

## Setup with event source mappings

To create an event source mapping with Kinesis, run the following CLI command:
```
awslocal lambda create-event-source-mapping \
    --function-name <your function name> \
    --event-source <resource ARN> \
    --batch-size 1 \
    --profile mgmt-developer \
    <options>
    --starting-position TRIM_HORIZON
```
For example, if your function name was `my_lambda` and you wanted to consume from a Kinesis stream, you might run something like the following:
```
awslocal lambda create-event-source-mapping \
    --function-name my_lambda \
    --event-source <Kinesis stream ARN> \
    --batch-size 1 \
    --starting-position TRIM_HORIZON
```

## Todos
- Enable lambda handler container to communicate with external services
- Hot reloading (unsure if this is possible)

## References:

This setup was made based on the following documentation:
- [https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
- [https://docs.localstack.cloud/user-guide/aws/lambda/](https://docs.localstack.cloud/user-guide/aws/lambda/)
- [https://docs.aws.amazon.com/lambda/latest/dg/python-package.html](https://docs.aws.amazon.com/lambda/latest/dg/python-package.html)
