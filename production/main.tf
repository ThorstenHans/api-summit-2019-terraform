terraform {
  backend "azurerm" {
    resource_group_name  = "api-summit-2019-state-backend"
    storage_account_name = "apisummit2019tfstate"
    container_name       = "apisummit"
    key                  = "YOUR_KEY"
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
