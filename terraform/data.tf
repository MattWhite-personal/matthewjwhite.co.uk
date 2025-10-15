# Ensure the DNS zone exists
data "azurerm_dns_zone" "matthewjwhite-co-uk" {
  name                = "matthewjwhite.co.uk"
}