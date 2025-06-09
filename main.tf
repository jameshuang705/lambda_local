locals {
  aws_account_id = "aws"
}

provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-west-2"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    lambda = "http://lambda-localstack:4566"
    iam = "http://lambda-localstack:4566"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


# Set function.zip to the name of your lambda function archive
resource "aws_lambda_function" "my_lambda" {
  filename = "function.zip"
  function_name = "handler"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "lambda.handler"
  runtime = "python3.11"
  source_code_hash = filebase64sha256("function.zip")
  environment {
    variables = {
      HOSTNAME = "lambda-localstack"
    }
  }
}
