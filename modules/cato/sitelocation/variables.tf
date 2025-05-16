# Cato Variables
variable "baseurl" {
  description = "Cato Networks API URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "cato_token" {
  description = "Cato Networks API Token"
  type        = string
}

variable "account_id" {
  description = "Cato Networks Account ID"
  type        = string
}