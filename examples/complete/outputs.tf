output "instance_id" {
  description = "The ID of the SQLServer Flex instance created by the example."
  value       = module.flex_sqlserver.instance_id
}

output "database_ids" {
  description = "The database IDs created by the example."
  value       = module.flex_sqlserver.database_ids
}

output "user_ids" {
  description = "The user IDs created by the example (app + login)."
  value       = module.flex_sqlserver.user_ids
}
