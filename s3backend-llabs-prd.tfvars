# Test LLabs - Windson Santana 
# How to execute
# Step 1: terraform init
# Step 2: terraform validate
# Setp 3: terraform plan -var-file="s3backend.tfvars" -var="createdBy=Goodtec"
# Setp 4: terraform apply -var-file="s3backend.tfvars" -var="createdBy=Goodtec"
# Setp 5: terraform destroy -var-file="s3backend.tfvars" -var="createdBy=Goodtec"

# Common
project = "llabs" # Nome da conta AWS

# General 
aws_region = "us-east-1"
aws_profile = "default"
aws_account_id = "816069124394"

# S3
s3_bucket_names       = ["s3-aws-llabs-trf-state-prd"]
s3_bucket_name        = "s3-aws-llabs-trf-state-prd"
s3_versioning         = "Enabled"
enable_lifecycle_rule = false

# DynamoDB
db_table_name = "dyndb-aws-llabs-trf-state-prd"
billing_mode  = "PAY_PER_REQUEST"
hash_key      = "LockID"
attr_name     = "LockID"
attr_type     = "S"