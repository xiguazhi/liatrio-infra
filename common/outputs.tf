output "client_certificate" {
  value     = azurerm_kubernetes_cluster.liatrio.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.liatrio.kube_config_raw
  sensitive = true
}

output "ssh_key" {
  value     = tls_private_key.liatrio.private_key_pem
  sensitive = true
}