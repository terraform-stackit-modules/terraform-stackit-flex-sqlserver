#####################################################################################
# "basic" example — self-contained, requires only `project_id`.
#
# Minimal SQLServer Flex instance with one user and one database owned by it.
#####################################################################################

module "flex_sqlserver" {
  source = "../.."

  project_id        = var.project_id
  name              = "example-sqlserver"
  sqlserver_version = "2022"
  flavor_id         = "4.16-Single"
  backup_schedule   = "0 0 * * *"
  retention_days    = 30

  storage = {
    class = "premium-perf2-stackit"
    size  = 5
  }

  network = {
    acl = ["0.0.0.0/0"]
  }

  users = {
    app = {
      username = "app_user"
      roles    = ["##STACKIT_DatabaseManager##"]
    }
  }

  databases = {
    app = {
      name  = "app_db"
      owner = "app_user"
    }
  }
}
