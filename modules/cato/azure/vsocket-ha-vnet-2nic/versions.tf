terraform {
  required_providers {
    cato = {
      source  = "catonetworks/cato"
      version = "0.0.57-1"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 1.5"
}
