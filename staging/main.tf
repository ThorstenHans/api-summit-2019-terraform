module "infrastructure" {
  source           = "../infrastructure"
  environment_name = "staging"
  asp_size         = "S2"
  custom_tags = {
    author = "Thomas"
  }
}

output "web_url" {
  value = module.infrastructure.website_url
}
