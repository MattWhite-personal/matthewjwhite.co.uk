data "azurerm_storage_account" "wedding_files" {
  name                = "stmajfies"
  resource_group_name = "RG-WhiteFam-UKS"
}

resource "azurerm_cdn_frontdoor_endpoint" "files-mattandjen-co-uk" {
  name                     = "afd-ep-files-mattandjen-co-uk"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd-whitefam.id
}

resource "azurerm_cdn_frontdoor_origin_group" "files-mattandjen-co-uk" {
  name                     = "afd-og-files-mattandjen-co-uk"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd-whitefam.id

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "files-mattandjen-co-uk" {
  name                           = "afd-o-files-mattandjen-co-uk"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.files-mattandjen-co-uk.id
  enabled                        = true
  certificate_name_check_enabled = false
  host_name                      = data.azurerm_storage_account.wedding_files.primary_web_host
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = data.azurerm_storage_account.wedding_files.primary_web_host
  priority                       = 1
  weight                         = 1
}

resource "azurerm_cdn_frontdoor_route" "files-mattandjen-co-uk" {
  name                          = "afd-rt-files-mattandjen-co-uk"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.files-mattandjen-co-uk.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.files-mattandjen-co-uk.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.files-mattandjen-co-uk.id]

  supported_protocols             = ["Http", "Https"]
  patterns_to_match               = ["/*"]
  forwarding_protocol             = "HttpsOnly"
  link_to_default_domain          = false
  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.files-mattandjen-co-uk.id]
  https_redirect_enabled          = true
}

resource "azurerm_cdn_frontdoor_custom_domain" "files-mattandjen-co-uk" {
  name                     = "afd-cd-files-mattandjen-co-uk"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd-whitefam.id
  host_name                = "files.${data.azurerm_dns_zone.mattandjen-co-uk.name}"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "files-mattandjen-co-uk" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.files-mattandjen-co-uk.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.files-mattandjen-co-uk.id]
}
