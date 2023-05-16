provider "tls" {
  source = "hashicorp/tls"
}

resource "tls_private_key" "liatrio" {
  algorithm = "RSA"
  rsa_bits  = 4096
}