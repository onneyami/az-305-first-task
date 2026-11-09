variable "location" {
  type        = string
  default     = "eastus"
  description = "Primary Azure region"
}

variable "project_name" {
  type        = string
  default     = "az305"
  description = "Identifier for project resources"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment tier"
}

variable "sql_admin_username" {
  type        = string
  default     = "sqladminuser"
  description = "Azure SQL administrator login"
}