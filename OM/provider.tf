provider "newrelic" {
  account_id           = var.account_id
  api_key              = var.api_key
  region               = var.region 
}

terraform {
  required_version = "~> 1.0"
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }/*
  backend "s3" {
  bucket         = "newrelic-statefile"
  key            = "terraform-aladtec.tfstate"
  region         = "us-east-1"
  profile = "dmiinfrastructure01"    
  }
  */
}
