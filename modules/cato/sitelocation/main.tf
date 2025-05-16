provider "cato" {
  baseurl    = var.baseurl
  token      = var.cato_token
  account_id = var.account_id
}

data "cato_siteLocation" "example-site" {
  filters = [
    {
      field     = "city"
      operation = "contains"
      search    = "San Diego"
    },
    {
      field     = "state_name"
      operation = "startsWith"
      search    = "Cali"
    },
    {
      field     = "country_name"
      operation = "exact"
      search    = "United States"
    }
  ]
}

module "site_location" {
  source        = "catonetworks/sitelocation/cato"
  csv_file_path = "site_locations.csv"
}
