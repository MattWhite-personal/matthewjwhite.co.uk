output "mjw-pip" {
  value = azurerm_public_ip.mjwsite.id
}

output "dev-swa" {
  value = azurerm_static_web_app.matthewjwhite-dev.default_host_name
}

output "mjw-dns-txt" {
  value     = azurerm_static_web_app_custom_domain.matthewjwhite-co-uk.validation_token == "" ? "validated" : azurerm_static_web_app_custom_domain.matthewjwhite-co-uk.validation_token
  sensitive = true
}

output "mjw-swa-id" {
  value = azurerm_static_web_app.matthewjwhite-co-uk.id
}

output "dev-mjw-dnsauth" {
  value     = azurerm_cdn_frontdoor_custom_domain.dev-matthewjwhite-co-uk.validation_token
  sensitive = true
}

output "dev-mjw-cdn-endpoint" {
  value = azurerm_cdn_frontdoor_endpoint.dev-matthewjwhite-co-uk.host_name
}

output "mjw-dnsauth" {
  value     = azurerm_cdn_frontdoor_custom_domain.matthewjwhite-co-uk.validation_token
  sensitive = true
}

output "mjw-cdn-endpoint" {
  value     = azurerm_cdn_frontdoor_endpoint.matthewjwhite-co-uk.id
  sensitive = true
}