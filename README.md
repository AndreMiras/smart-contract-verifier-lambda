# Smart Contract Verifier Lambda

AWS Lambda function for the [Smart Contract Verifier](https://github.com/AndreMiras/smart-contract-verifier.js)

## Deploy

```sh
export $(grep -v '^#' .env | xargs -0)
make devops/terraform/plan
make devops/terraform/apply
```
