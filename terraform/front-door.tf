resource "azurerm_cdn_frontdoor_profile" "afd-whitefam" {
  name                = "afd-whitefam"
  resource_group_name = azurerm_resource_group.webservers.name
  sku_name            = "Standard_AzureFrontDoor"
  tags                = local.tags
}
