terraform {
  required_providers {
    cato = {
      source  = "catonetworks/cato"
      version = ">= 0.0.70"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.98.0"
    }
  }
}
