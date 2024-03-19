#!/bin/bash
git pull origin main
terraform init
terraform fmt
terraform validate
terraform apply --auto-approve