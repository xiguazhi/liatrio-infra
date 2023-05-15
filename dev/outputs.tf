output "client_certificate" {
  value     = module.liatrio-demo.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = module.liatrio-demo.kube_config
  sensitive = true
}

output "liatrio_ip" {
  value = module.liatrio-demo.liatrio_ip
}