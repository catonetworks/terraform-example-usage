terraform {
  required_providers {
    cato = {
      source = "catonetworks/cato"
    }
  }
}

provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}
