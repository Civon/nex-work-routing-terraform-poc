variable "app_name" {
  default = "nex-work-prod"
}

variable "sku_name" {
  default     = "F1"
  description = "SKU size of webapp"
}

variable "always_on" {
  default     = false
  description = "For F1 plan, always_on must be false"
}

variable "docker_registry_url" {
  type      = string
  sensitive = true
}
variable "docker_registry_username" {
  type      = string
  sensitive = true
}
variable "docker_registry_password" {
  type      = string
  sensitive = true
}

variable "websites_enable_app_service_storage" {
  description = "Whether to enable storage for the website"
  type        = bool
  default     = false
}


variable "storage_account_access_key" {
  description = "The access key for the Azure Storage account."
  sensitive   = true
  # default     = null
}

variable "storage_account_name" {
  description = "The name of the Azure Storage account."
  # default     = null
}

variable "storage_file_share_name" {
  description = "The name of the file share to mount."
  # default     = null
}
variable "storage_mount_path" {
  description = "The path of the file share to mount in webapp"
  # default     = null
}
