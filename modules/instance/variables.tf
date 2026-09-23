variable "project_id" {
  description = "STACKIT project ID to which the instance is associated."
  type        = string
}

variable "create_instance" {
  description = "Whether to create the SQLServer Flex instance."
  type        = bool
  default     = true
}

variable "name" {
  description = "Instance name."
  type        = string
}

variable "sqlserver_version" {
  description = "The SQLServer version, e.g. \"2022\"."
  type        = string
  default     = null
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

variable "flavor_id" {
  description = "The flavor ID, e.g. \"4.16-Single\". List available flavors with the `stackit_sqlserverflex_flavors` data source."
  type        = string
  default     = null
}

variable "backup_schedule" {
  description = "Cron expression for the backup schedule, e.g. \"0 0 * * *\"."
  type        = string
  default     = null
}

variable "retention_days" {
  description = "Days (30 to 90) the backup files are retained before cleanup."
  type        = number
  default     = null

  validation {
    condition     = var.retention_days == null || (coalesce(var.retention_days, 30) >= 30 && coalesce(var.retention_days, 30) <= 90)
    error_message = "retention_days must be between 30 and 90."
  }
}

variable "storage" {
  description = "Storage configuration: `{ class = <storage class>, size = <GB> }`."
  type = object({
    class = optional(string)
    size  = optional(number)
  })
  default = null
}

variable "network" {
  description = "Network configuration: `{ acl = [<CIDR>...], access_scope = \"PUBLIC\"|\"SNA\" }`."
  type = object({
    acl          = optional(list(string))
    access_scope = optional(string)
  })
  default = null
}
