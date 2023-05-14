variable "resource_prefix" {}
variable "subnets" {
  default = [
    {
      name = "PLACEHOLDER1"
      prefix = "10.0.0.0/24"
      services = []
      service_delegaation = false
    },
    {
      name = "PLACEHOLDER2"
      prefix = "10.2.10.0/24"
      services = []
      service_delegaation = true

    }
  ]
}
variable "environment" {}