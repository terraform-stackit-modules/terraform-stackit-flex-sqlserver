module "instance" {
  source = "./modules/instance"

  create_instance   = var.create_instance
  project_id        = var.project_id
  region            = var.region
  name              = var.name
  sqlserver_version = var.sqlserver_version
  flavor_id         = var.flavor_id
  backup_schedule   = var.backup_schedule
  retention_days    = var.retention_days
  storage           = var.storage
  network           = var.network
}

module "user" {
  source = "./modules/user"

  project_id  = var.project_id
  region      = var.region
  instance_id = coalesce(module.instance.instance_id, var.instance_id)
  users       = var.users
}

module "database" {
  source = "./modules/database"

  project_id  = var.project_id
  region      = var.region
  instance_id = coalesce(module.instance.instance_id, var.instance_id)
  databases   = var.databases

  # A database's `owner` must already exist. The owner is a plain string (not a
  # reference to module.user), so Terraform sees no implicit dependency — force
  # users to be created before any database via depends_on.
  depends_on = [module.user]
}
