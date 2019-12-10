output "website_url" {
  value     = azurerm_app_service.apisummitas.default_site_hostname
  sensitive = false
  // sensitive = true for keys and passwords
}
