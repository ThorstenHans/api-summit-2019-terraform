provider "azurerm" {
}

resource "azurerm_resource_group" "apisummitglobal" {
  location = "northeurope"
  name     = "api-summit-2019-state-backend"
}

resource "azurerm_storage_account" "apisummitstatebackend" {
  location                 = azurerm_resource_group.apisummitglobal.location
  resource_group_name      = azurerm_resource_group.apisummitglobal.name
  name                     = "apisummit2019tfstate"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "apisummitcontainer" {
  storage_account_name = azurerm_storage_account.apisummitstatebackend.name
  name                 = "apisummit"

}
