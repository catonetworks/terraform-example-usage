ingress_cidr_blocks = ["0.0.0.0/0"]
key_pair            = "cato-keypair-us-west-2"
vpc_range           = "10.1.0.0/16"
subnet_range_mgmt   = "10.1.1.0/24"
subnet_range_wan    = "10.1.2.0/24"
subnet_range_lan    = "10.1.3.0/24"
mgmt_eni_ip         = "10.1.1.5"
wan_eni_ip          = "10.1.2.5"
lan_eni_ip          = "10.1.3.5"
site_name           = "Cato-AWS-us-west-2 VPC"
region              = "us-west-2"
site_description    = "AWS Site us-west-2 VPC"
site_location = {
  city         = "San Diego"
  country_code = "US"
  state_code   = "US-CA" ## Optional - for countries with states
  timezone     = "America/Los_Angeles"
}