terraform {
  required_providers {
    cato = {
      source = "catonetworks/cato"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.98.0"
    }
  }
}
