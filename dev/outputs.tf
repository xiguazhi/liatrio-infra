output "client_certificate" {
  value     = module.liatrio-demo.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = module.liatrio-demo.kube_config
  sensitive = true
}

output "ssh_key" {
  value = module.liatrio-demo.ssh_key
  sensitive = true
}
