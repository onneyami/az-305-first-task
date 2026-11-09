variable "location" {
  type        = string
  default     = "eastus"
  description = "Target Azure region for state resources"
}

variable "prefix" {
  type        = string
  default     = "az305tf"
  description = "Prefix used in storage naming"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Bootstrap"
    ManagedBy   = "Terraform"
    Project     = "AZ-305"
  }
}