module "infra1" {
  source           = "../infrastructure"
  environment_name = "development-thorsten"
  asp_size         = "S1"
  custom_tags = {
    author = "ThH"
  }
}

output "web1_url" {
  value = module.infra1.website_url
}

