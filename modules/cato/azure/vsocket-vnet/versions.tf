terraform {
  required_providers {
    cato = {
      source = "catonetworks/cato"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 0.13"
}
