# AWS region where resources will be created
region = "us-east-1"
# BGP ASN for the AWS customer gateway (Amazon default is 65000, but it can be changed)
bgp_asn = 65000
# Public IP address for the AWS customer gateway (replace with your actual IP)
cgw_ip = "45.62.186.108"
# Name of the IPSec site in Cato (replace with the desired site name)
site_name = "AWS-Cato-IPSec-Site"
# Description of the IPSec site in Cato (replace with the desired description)
site_description = "TestTFAWSIPSec"
# Native network range for the IPSec site (replace with the desired network range)
native_network_range = "172.33.16.0/20"
# Private IP address of the Cato side for the primary tunnel (replace with the desired value)
primary_private_cato_ip = "169.1.1.2"
# Private IP address of the site side for the primary tunnel (replace with the desired value)
primary_private_site_ip = "169.1.1.3"
# Public IP address ID of the Cato side for the primary tunnel (replace with the desired value)
primary_public_cato_ip_id = "31511" # NY
# Downstream bandwidth in Mbps for the primary tunnel (replace with the desired value)
#primary_downstream_bw = 100
# Upstream bandwidth in Mbps for the primary tunnel  (replace with the desired value)
#primary_upstream_bw = 100
# Private IP address of the Cato side for the secondary tunnel (replace with the desired value)
secondary_private_cato_ip = "169.2.1.2"
# Private IP address of the site side for the secondary tunnel (replace with the desired value)
secondary_private_site_ip = "169.2.1.3"
# Public IP address ID of the Cato side for the secondary tunnel (replace with the desired value)
secondary_public_cato_ip_id = "31512" # Ashburn
# Downstream bandwidth in Mbps for the secondary tunnel (replace with the desired value)
#secondary_downstream_bw = 100
# Upstream bandwidth in Mbps for the secondary tunnel  (replace with the desired value)
#secondary_upstream_bw = 100
# Downstream bandwidth in Mbps for the IPSec tunnel in Cato (replace with the desired value)
downstream_bw = 100
# Upstream bandwidth in Mbps for the IPSec tunnel in Cato  (replace with the desired value)
upstream_bw = 100
site_location = {
  city         = "New York City"
  country_code = "US"
  state_code   = "US-NY" ## Optional - for countries with states
  timezone     = "America/New_York"
}
