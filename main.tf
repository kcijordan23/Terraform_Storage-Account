# Provider being used

provider "azurerm" {
  features {}

}

# Create Resource Group

resource "azurerm_resource_group" "dev-rg" {
  name     = "dev-terraform-rg"
  location = "UK south"
  tags = {
    environment = "dev"
  }

}

# create a storage account

resource "azurerm_storage_account" "dev_storage_acc" {
  name                     = "devstorageacc23452345"
  resource_group_name      = azurerm_resource_group.dev-rg.name
  location                 = azurerm_resource_group.dev-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"

  }

  tags = {
    environment = "dev"
  }
}

# Add a index file to the storage account

resource "azurerm_storage_blob" "dev-blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.dev_storage_acc.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "<h1> Hi, this is a website using Terraform </h1>"
}
