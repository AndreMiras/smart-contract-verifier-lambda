provider "aws" {
  region = var.aws_region
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.6.0"

  function_name         = "smart-contract-verifier"
  handler               = "index.lambda_handler"
  runtime               = "nodejs16.x"
  memory_size           = var.memory_size
  timeout               = var.timeout
  environment_variables = var.environment_variables

  # Lambda Function URL
  create_lambda_function_url = true
  authorization_type         = "NONE"
  cors = {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["POST"]
    max_age           = 86400
  }

  source_path = [
    {
      path = "../",
      commands = [
        # make sure node_modules/ doesn't contain any unecessary deps e.g. dev ones
        "rm -rf node_modules/",
        "NODE_ENV=production npm ci",
        ":zip"
      ],
      patterns = [
        "!terraform/.*",
      ]
    }
  ]
}
