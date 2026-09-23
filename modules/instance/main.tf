resource "stackit_sqlserverflex_instance" "this" {
  count = var.create_instance ? 1 : 0

  project_id      = var.project_id
  region          = var.region
  name            = var.name
  version         = var.sqlserver_version
  flavor_id       = var.flavor_id
  backup_schedule = var.backup_schedule
  retention_days  = var.retention_days

  storage = var.storage
  network = var.network
}
