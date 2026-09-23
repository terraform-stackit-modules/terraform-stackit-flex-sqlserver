output "database_ids" {
  description = "Map of database key to database ID."
  value       = { for k, d in stackit_sqlserverflex_database.this : k => d.database_id }
}
