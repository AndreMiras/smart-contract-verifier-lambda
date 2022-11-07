AWS_REGION?=us-east-1
URL_ID?=4ku2s22lghblcahdndg7td2tqm0tbxdt

run/lambda/invoke:
	AWS_REGION=$(AWS_REGION) aws lambda invoke \
	--function-name smart-contract-verifier \
	--cli-binary-format raw-in-base64-out \
	--payload '{ "key1": "value1" }' response.json

run/lambda/curl:
	curl --verbose \
	'https://$(URL_ID).lambda-url.$(AWS_REGION).on.aws/' \
	--header 'content-type: application/json' \
	--data '{ "key1": "value1" }'

run/lambda: run/lambda/invoke

devops/terraform/fmt:
	terraform -chdir=terraform fmt

devops/terraform/init:
	terraform -chdir=terraform init

devops/terraform/plan:
	terraform -chdir=terraform plan \
	-var='environment_variables={"RPC_PROVIDER":"$(RPC_PROVIDER)"}'

devops/terraform/apply:
	terraform -chdir=terraform apply -auto-approve \
	-var='environment_variables={"RPC_PROVIDER":"$(RPC_PROVIDER)"}'

devops/terraform/output/lambda_function_url:
	terraform -chdir=terraform output lambda_function_url

devops/terraform/destroy:
	terraform -chdir=terraform destroy -auto-approve
