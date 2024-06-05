resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    zones  = [1]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" 
  }
}

data "azurerm_kubernetes_cluster" "example" {
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.aks-rg.name
}



  resource "azurerm_kubernetes_cluster_node_pool" "example" {
    name                = "adityatest"
    node_count          = var.user_node
    vm_size             = "Standard_DS2_v2"
    zones               = [1]
    enable_auto_scaling = false
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.example.id

}