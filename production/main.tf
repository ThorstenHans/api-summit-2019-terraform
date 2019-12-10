terraform {
  backend "azurerm" {
    resource_group_name  = "api-summit-2019-state-backend"
    storage_account_name = "apisummit2019tfstate"
    container_name       = "apisummit"
    key                  = "MlS6QrzUJIo2hPRUBnuri+L6mZ8R5z9CQtYxA+5cE3cN+bhVK8SM0f1qyeUwQC9+11gUZ1R99QYpEP4TupH3ug=="
  }
}

module "infrastructure" {
  source           = "../infrastructure"
  environment_name = "production"
  asp_size         = "S2"
  custom_tags = {
    author = "Thomas"
  }
  deploy_s3_bucket = false
}

output "web_url" {
  value = module.infrastructure.website_url
}
