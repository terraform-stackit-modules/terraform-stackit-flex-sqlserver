#####################################################################################
# "replica" example — self-contained, requires only `project_id`.
#
# High-availability SQLServer Flex. NOTE: like the other SQL Flex engines (and unlike
# AWS RDS `replicate_source_db`), STACKIT replication is carried by the FLAVOR — pick a
# replicated flavor to provision a managed primary/replica topology. There is no
# separate "replica instance" resource to wire to a source.
#####################################################################################

module "flex_sqlserver" {
  source = "../.."

  project_id        = var.project_id
  name              = "example-sqlserver-replica"
  sqlserver_version = "2022"

  # Replicated flavor → managed primary + replica(s). Adjust to an available
  # replicated flavor from the stackit_sqlserverflex_flavors data source.
  flavor_id       = "4.16-Single"
  backup_schedule = "0 0 * * *"
  retention_days  = 30

  storage = {
    class = "premium-perf2-stackit"
    size  = 5
  }

  network = {
    acl = ["10.0.0.0/8"]
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
