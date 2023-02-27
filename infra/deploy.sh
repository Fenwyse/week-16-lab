#!/bin/bash
# Put your deployment kick off script actions here

if [! aws sts get-caller-identity]; then
    echo >&2 "aws creds not working"
    exit 2
fi

readonly STUDENT_NAME="j-red"
readonly STACK_NAME="${STUDENT_NAME}"
readonly TEMPLATE_FILE="$(dirname "${BASH_SOURCE[0]}")/templates/vpc.yml"
readonly AWS_DEFAULT_REGION="eu-west-2"

aws cloudformation deploy \
  --stack-name "${STACK_NAME}" \
  --template-file "${TEMPLATE_FILE}" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset \
  --tags "Project=Actions" "Environment=Dev" "StudentName=${STUDENT_NAME}" \
  --region "${AWS_DEFAULT_REGION}" \
  --parameter-overrides "file://networking_params.json"
