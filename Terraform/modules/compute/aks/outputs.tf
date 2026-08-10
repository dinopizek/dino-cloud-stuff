output "id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "AKS id"
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  description = "AKS OIDC issuer URL"
}