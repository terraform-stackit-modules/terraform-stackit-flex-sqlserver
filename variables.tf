# ─── Core ─────────────────────────────────────────────────────────────────────

variable "project_id" {
  description = "STACKIT project ID to which the SQLServer Flex instance, databases and users are associated."
  type        = string
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

# ─── Instance ─────────────────────────────────────────────────────────────────

variable "create_instance" {
  description = "Whether to create the SQLServer Flex instance. Set to false to manage databases/users against an existing instance provided via `instance_id`."
  type        = bool
  default     = true
}

variable "instance_id" {
  description = "ID of an existing SQLServer Flex instance. Used for databases/users when `create_instance` is false."
  type        = string
  default     = null
}

variable "name" {
  description = "Instance name."
  type        = string
  default     = null
}

variable "sqlserver_version" {
  description = "The SQLServer version, e.g. \"2022\"."
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
  description = "Network configuration: `{ acl = [<CIDR>...], access_scope = \"PUBLIC\"|\"SNA\" }`. Recommended to set to avoid future breaking changes."
  type = object({
    acl          = optional(list(string))
    access_scope = optional(string)
  })
  default = null
}

# ─── Databases ────────────────────────────────────────────────────────────────

variable "databases" {
  description = <<-EOT
    Map of databases to create, keyed by a stable identifier. Each value:
      - `name`          : database name.
      - `owner`         : username of the database owner (a user created via `users`, or existing).
      - `collation`     : optional collation, e.g. "SQL_Latin1_General_CP1_CI_AS".
      - `compatibility` : optional compatibility level, e.g. 160.
    Databases are created AFTER users (depends_on) so a database owner already exists.
  EOT
  type = map(object({
    name          = string
    owner         = string
    collation     = optional(string)
    compatibility = optional(number)
  }))
  default = {}
}

# ─── Users ────────────────────────────────────────────────────────────────────

variable "users" {
  description = <<-EOT
    Map of users to create, keyed by a stable identifier. Each value:
      - `username`            : the user name.
      - `roles`               : set of access roles (STACKIT default roles like
                                `##STACKIT_DatabaseManager##`, `##STACKIT_LoginManager##`, ...).
      - `rotate_when_changed` : optional map whose change forces password rotation.
    Generated passwords are exposed via the `user_passwords` output (sensitive).
  EOT
  type = map(object({
    username            = string
    roles               = set(string)
    rotate_when_changed = optional(map(string))
  }))
  default = {}
}
