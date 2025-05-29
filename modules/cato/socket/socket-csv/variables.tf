variable "site_name" {
  description = "The name of the site, e.g., Cato-X1600-BA."
  type        = string
  default     = "Cato-X1600-Site"
}

variable "site_description" {
  description = "A brief description of the site, e.g., Cato-X1600."
  type        = string
  default     = "Cato X1600 Site"
}

variable "native_network_range" {
  description = "The native network range for the site in CIDR notation, e.g., 10.150.0.0/24."
  type        = string
  default     = "10.150.0.0/16"
}

variable "local_ip" {
  description = "The local IP address of the site, e.g., 10.150.0.5."
  type        = string
  default     = "10.150.0.5"
}

variable "site_type" {
  description = "The type of the site, e.g., BRANCH."
  type        = string
  default     = "BRANCH"
}

variable "connection_type" {
  description = "The type of connection for the site, e.g., SOCKET_X1600."
  type        = string
  default     = "SOCKET_X1600"
}

variable "site_location" {
  description = "Site location information."
  type = object({
    address      = string
    city         = string
    country_code = string
    state_code   = string
    timezone     = string
  })
  default = {
    address      = "123 Main St"
    city         = "New York City"
    country_code = "US"
    state_code   = "US-NY"
    timezone     = "America/New_York"
  }
}


variable "cato_interfaces" {
  description = "Cato WAN interfaces for the site."
  type = list(object({
    interface_id         = string
    name                 = string
    upstream_bandwidth   = string
    downstream_bandwidth = string
    role                 = string
    precedence           = string
  }))
  default = [{
    interface_id         = "INT_4"
    name                 = "Interface wan 4"
    upstream_bandwidth   = 100
    downstream_bandwidth = 100
    role                 = "wan_2"
    precedence           = "ACTIVE"
  }]
}

variable "socket_lan_network_ranges_csv_path" {
  description = "Path to the CSV file containing socket LAN network ranges."
  type        = string
}