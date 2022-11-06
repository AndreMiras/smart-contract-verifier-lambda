# Smart Contract Verifier Lambda

[![Tests](https://github.com/AndreMiras/smart-contract-verifier-lambda/workflows/Tests/badge.svg)](https://github.com/AndreMiras/smart-contract-verifier-lambda/actions/workflows/tests.yml)

AWS Lambda function for the [Smart Contract Verifier](https://github.com/AndreMiras/smart-contract-verifier.js)

## Deploy

```sh
export $(grep -v '^#' .env | xargs -0)
make devops/terraform/plan
make devops/terraform/apply
```
