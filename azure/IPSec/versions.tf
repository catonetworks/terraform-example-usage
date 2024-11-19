terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    cato = {
      source  = "registry.terraform.io/catonetworks/cato"
      version = "~> 0.0.8"
    }
  }
}
