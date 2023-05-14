variable "resource_prefix" {}
variable "subnets" {
  default = [
    {
      name = "k8s-cluster"
      prefix = "10.1.10.0/24"
      services = [ "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.ContainerRegistry"]
      service_delegaation = false
    },
    {
      name = "aci-vnet"
      prefix = "10.2.10.0/24"
      services = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.EventHub", "Microsoft.ContainerRegistry"]
      service_delegaation = true

    }
  ]
}
variable "environment" {}