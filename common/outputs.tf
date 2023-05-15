output "client_certificate" {
  value     = azurerm_kubernetes_cluster.liatrio.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.liatrio.kube_config_raw
  sensitive = true
}

output "liatrio_ip" {
  value = data.azurerm_public_ip.liatrio.ip_address
}