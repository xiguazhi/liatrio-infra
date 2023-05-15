resource "azurerm_kubernetes_cluster" "liatrio" {
  name                = format("%s-k8s", var.resource_prefix)
  location            = azurerm_resource_group.liatrio.location
  resource_group_name = azurerm_resource_group.liatrio.name
  vnet_subnet_id        = azurerm_subnet.sub["k8s-cluster"].id
  dns_prefix          = "k8sdemo"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = var.environment
    application = "K8s"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "liatrio" {
  name                  = "liatriodemo"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.liatrio.id
  vm_size               = "Standard_DS2_v2"
  vnet_subnet_id        = azurerm_subnet.sub["k8s-cluster"].id
  node_count            = 1

  tags = {
    Environment = var.environment
    application = "liatrio-demo"
  }
}

resource "azurerm_role_assignment" "liatrio-acr" {
  principal_id                     = azurerm_kubernetes_cluster.liatrio.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.liatrio.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "liatrio-network" {
  scope                = azurerm_subnet.sub["aci-vnet"].id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.liatrio.identity.0.principal_id
}

# data "azurerm_public_ip" "liatrio" {
#   name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.liatrio.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
#   resource_group_name = azurerm_resource_group.liatrio.name
# }