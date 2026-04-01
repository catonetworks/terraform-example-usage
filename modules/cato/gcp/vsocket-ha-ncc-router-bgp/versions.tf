terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.4"
    }
    cato = {
      source  = "catonetworks/cato"
      version = "~> 0.0.46"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.1"
    }
  }
  required_version = ">= 0.13"
}
