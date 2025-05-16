# Cato Variables
variable "baseurl" {
  description = "Cato Networks API URL"
  type        = string
  default     = "https://api.catonetworks.com/api/v1/graphql2"
}

variable "cato_token" {
  description = "Cato Networks API Token"
  type        = string
  #sensitive   = true
}

variable "account_id" {
  description = "Account ID"
  type        = number
  default     = null
}

## Internet Firewall Rules Module
variable "rbi_category" {
  type        = string
  description = "List of block domains"
  default     = "Unsanctioned"
}

variable "block_domains" {
  type        = list(string)
  description = "List of block domains"
  default     = []
}

variable "prompt_domains" {
  type        = list(string)
  description = "List of prompt domains"
  default     = []
}

variable "allow_domains" {
  type        = list(string)
  description = "List of allow domains"
  default     = []
}

variable "ifw_group_names" {
  type = list(object({
    name = string
  }))
  description = "List of group names"
  default     = []
}

