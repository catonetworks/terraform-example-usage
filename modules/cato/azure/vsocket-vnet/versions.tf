terraform {
  required_providers {
    cato = {
      source  = "catonetworks/cato"
      version = ">= 0.0.70"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 1.5"
}
