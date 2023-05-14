variable "resource_prefix" {}
variable "resource_group_name" {}
variable "key_vault_name" {}
variable "subnets" {
  type = list(object({
    name               = string
    prefix             = string
    services           = list(string)
    service_delegation = bool

  }))
  default = [
    {
      name               = "PLACEHOLDER1"
      prefix             = "10.0.0.0/24"
      services           = []
      service_delegation = false
    },
    {
      name               = "PLACEHOLDER2"
      prefix             = "10.2.10.0/24"
      services           = []
      service_delegation = true

    }
  ]
}
variable "environment" {}