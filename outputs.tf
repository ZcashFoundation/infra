# output "pool_id" {
#   description = "Pool ID"
#   value       = module.gh_oidc.id
# }

output "pool_name" {
  description = "Pool name"
  value       = module.gh_oidc.pool_name
}

output "provider_name" {
  description = "Provider name"
  value       = module.gh_oidc.provider_name
}
