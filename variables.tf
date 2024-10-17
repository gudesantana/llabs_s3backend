variable "project" {}
variable "createdBy" {
  type    = string
  default = "llabs"
}
variable "aws_region" {}
variable "aws_profile" {}
variable "aws_account_id" {}
variable "s3_bucket_names" {}
variable "s3_bucket_name" {}
variable "s3_versioning" {}
variable "enable_lifecycle_rule" {}
variable "db_table_name" {}
variable "billing_mode" {}
variable "hash_key" {}
variable "attr_name" {}
variable "attr_type" {}