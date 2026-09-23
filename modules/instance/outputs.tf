output "instance_id" {
  description = "The ID of the SQLServer Flex instance (null when create_instance is false)."
  value       = var.create_instance ? stackit_sqlserverflex_instance.this[0].instance_id : null
}

output "edition" {
  description = "The edition of the SQLServer instance (null when create_instance is false)."
  value       = var.create_instance ? stackit_sqlserverflex_instance.this[0].edition : null
}
