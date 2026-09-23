#####################################################################################
# "complete" example — self-contained, requires only `project_id`.
#
# Prod-like SQLServer Flex: restricted ACL, longer retention, a database with an
# explicit collation/compatibility, and multiple users. Mirrors the "complete-mssql"
# example of terraform-aws-modules/terraform-aws-rds.
#####################################################################################

module "flex_sqlserver" {
  source = "../.."

  project_id        = var.project_id
  name              = "example-sqlserver-complete"
  sqlserver_version = "2022"
  flavor_id         = "4.16-Single"
  backup_schedule   = "0 2 * * *"
  retention_days    = 60

  storage = {
    class = "premium-perf2-stackit"
    size  = 10
  }

  network = {
    acl = ["10.0.0.0/8"]
  }

  users = {
    app = {
      username = "app_user"
      roles    = ["##STACKIT_DatabaseManager##"]
    }
    login = {
      username = "login_user"
      roles    = ["##STACKIT_LoginManager##"]
    }
  }

  databases = {
    app = {
      name          = "app_db"
      owner         = "app_user"
      collation     = "SQL_Latin1_General_CP1_CI_AS"
      compatibility = 160
    }
  }
}
