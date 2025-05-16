# terraform-cato-bulk-sitelocation

Terraform module that takes a path to a csv file as an input, and validates each city, state (if applicable), and country against the Cato siteLocation database and provides outputs to reference dynamically to create sites in bulk. 

## NOTE
For csv files that include entries with unicode characters, use a text editor like [BBEdit](https://www.barebones.com/products/bbedit/download.html) or [Notepad++](https://notepad-plus-plus.org/) to change the encoding of the csv file to utf8 without utf8 BOM for terraform to read the file correctly. 

<details>
<summary>Example CSV file format</summary>

Create a csv file with the following format.  The first row is the header row and the remaining rows are the asset data.  The header row is used to map the column data to the asset attributes.

```csv
site_name,city,state_name,country_name
site1,Paris,,France
site2,New York City,New York,United
site3,Los Angeles,California,United States
```

</details>

## Example Bulk Import Usage

<details>
<summary>Example Variables for Bulk Import</summary>

## Example Variables for Bulk Import

```hcl
variable "csv_file_path" {
	description =  "Path to the csv file to import"
	type = string
	default = "site_locations.csv"
}

```
</details>

## Proviers and Resources for Bulk Run

```hcl
provider "cato" {
  baseurl    = "https://api.catonetworks.com/api/v1/graphql2"
  token      = "xxxxxxxxxxxxxx"
  account_id = "xxxxxxxxxxxxxx"
}

module "site_location" {
  source = "catonetworks/sitelocation/cato"
  csv_file_path = var.csv_file_path
}

## Add outputs to see siteLocation results for reference
output "invalid_sites" {
  value = module.site_location.invalid_sites
}

output "site_locations" {
  value = {
    for site_name, site in module.site_location.valid_sites : 
      site_name => {
        location_count = site.location_count
        is_valid       = site.is_valid
        locations      = [
          for i, location in site.locations : {
            city         = location.city
            country_code = location.country_code
            country_name = location.country_name
            state_code   = location.state_code
            state_name   = location.state_name
            timezone     = location.timezone
          }
        ]
      }
  }
}

# Use the results from the siteLocation module as inputs when creating a site
resource "cato_socket_site" "aws-site" {
  name            = "Example AWS Site"
  description     = "Site description"
  site_type       = "CLOUD_DC"
  connection_type = "SOCKET_AWS1500"

  native_range = {
    native_network_range = "192.169.35.0/24"
    local_ip             = "192.169.35.5"
  }

  site_location = {
    city         = lookup(module.site_location.valid_sites["site2"].locations[0], "city", null)
    country_code = lookup(module.site_location.valid_sites["site2"].locations[0], "country_code", null)
    state_code   = lookup(module.site_location.valid_sites["site2"].locations[0], "state_code", null)
    timezone     = lookup(module.site_location.valid_sites["site2"].locations[0], "timezone", null)[0]
  }
}
```

## Cato CLI for site location quick search

You can also use the [Cato CLI](https://github.com/catonetworks/cato-cli) to quickly lookup site location sytax searching for for city, stateName, and countryName.

```bash
$ pip3 install catocli
$ export CATO_TOKEN="your-api-token-here"
$ export CATO_ACCOUNT_ID="your-account-id"
$ catocli query siteLocation -h

$ catocli query siteLocation '{"filters":[{"search": "San Diego","field":"city","operation":"exact"}]}' -p

$ catocli query siteLocation '{"filters":[{"search": "New York City","field":"city","operation":"startsWith"},{"search": "New York","field":"stateName","operation":"endsWith"},{"search": "United States","field":"countryName","operation":"contains"}}' -p
```
