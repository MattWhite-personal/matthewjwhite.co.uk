resource "azurerm_static_web_app" "matthewjwhite-dev" {
  name                = "matthewjwhite-dev"
  resource_group_name = azurerm_resource_group.webservers.name
  location            = "westeurope"
  sku_size            = "Standard"
  sku_tier            = "Standard"
  tags                = local.tags

  lifecycle {
    ignore_changes = [
      repository_branch,
      repository_url,
      repository_token
    ]
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "dev-matthewjwhite-co-uk" {
  name                     = "afd-ep-dev-matthewjwhite-co-uk"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd-whitefam.id
}

resource "azurerm_cdn_frontdoor_origin_group" "dev-matthewjwhite-co-uk" {
  name                     = "afd-og-dev-matthewjwhite-co-uk"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd-whitefam.id

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "dev-matthewjwhite-co-uk" {
  name                           = "afd-o-dev-matthewjwhite-co-uk"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.dev-matthewjwhite-co-uk.id
  enabled                        = true
  certificate_name_check_enabled = false
  host_name                      = azurerm_static_web_app.matthewjwhite-dev.default_host_name
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = azurerm_static_web_app.matthewjwhite-dev.default_host_name
  priority                       = 1
  weight                         = 1
}

resource "azurerm_cdn_frontdoor_route" "dev-matthewjwhite-co-uk" {
  name                          = "afd-rt-dev-matthewjwhite-co-uk"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.dev-matthewjwhite-co-uk.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.dev-matthewjwhite-co-uk.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.dev-matthewjwhite-co-uk.id]

  supported_protocols             = ["Http", "Https"]
  patterns_to_match               = ["/*"]
  forwarding_protocol             = "HttpsOnly"
  link_to_default_domain          = false
  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.dev-matthewjwhite-co-uk.id]
  https_redirect_enabled          = true
}

resource "azurerm_cdn_frontdoor_custom_domain" "dev-matthewjwhite-co-uk" {
  name                     = "afd-cd-dev-matthewjwhite-co-uk"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd-whitefam.id
  host_name                = azurerm_dns_zone.tftest-mjw.name

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "dev-matthewjwhite-co-uk" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.dev-matthewjwhite-co-uk.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.dev-matthewjwhite-co-uk.id]
}
