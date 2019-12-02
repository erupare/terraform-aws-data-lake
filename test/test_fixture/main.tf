provider "aws" {
  region = "us-west-2"
}

locals {
  tags = {
    test = "unit-test"
  }
}

module "glue" {
  source = "../../modules/glue"

  name        = "data_lake_tf_test"
  description = "Glue DB for Terraform test"
}

module "iam" {
  source = "../../modules/iam"

  name               = "data-lake-tf-test-iam-role"
  s3_bucket          = "data_lake_tf_test_s3_bucket"
  glue_database_name = "data_lake_tf_test"
  external_ids       = ["test_external_id_1", "test_external_id_2"]
  tags               = "${local.tags}"
}

module "emr" {
  source = "../../modules/emr"

  s3_bucket = "data_lake_tf_test_s3_bucket"
  subnet_id = "subnet-00f137e4f3a6f8356"
  tags      = "${local.tags}"
}