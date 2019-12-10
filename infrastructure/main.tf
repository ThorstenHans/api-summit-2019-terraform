

locals {
  default_tags = {
    tool   = "Terraform"
    author = ""
  }

  all_tags = merge(local.default_tags, var.custom_tags)
}

resource "azurerm_resource_group" "apisummitrg" {
  location = "westeurope"
  name     = "api-summit-2019-${var.environment_name}"
  tags     = local.all_tags
}

resource "azurerm_app_service_plan" "apisummitasp" {
  location            = azurerm_resource_group.apisummitrg.location
  name                = "asp-apisummit2019-${var.environment_name}"
  resource_group_name = azurerm_resource_group.apisummitrg.name
  tags                = local.all_tags
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = var.asp_size
  }

}


resource "azurerm_app_service" "apisummitas" {
  location            = azurerm_resource_group.apisummitrg.location
  name                = "apisummit2019-${var.environment_name}"
  resource_group_name = azurerm_resource_group.apisummitrg.name
  app_service_plan_id = azurerm_app_service_plan.apisummitasp.id
  tags                = local.all_tags
  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|nginx:latest"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_application_insights" "apisummitai" {
  location            = azurerm_resource_group.apisummitrg.location
  name                = "ai-apisummit2019-${var.environment_name}"
  resource_group_name = azurerm_resource_group.apisummitrg.name
  application_type    = "web"
}

resource "aws_s3_bucket" "apisummits3bucket" {
  bucket = "api-summit-2019"
  acl    = "public-read-write"
  count  = var.deploy_s3_bucket ? 1 : 0
}

data "aws_ami" "ubuntuimg" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-eoan-19.10-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "apisummitec2instance" {
  ami           = data.aws_ami.ubuntuimg.id
  instance_type = "t2.micro"
  count         = 2
  tags          = merge(local.all_tags, { Name = "apisummitinstance" })
}

resource "azurerm_redis_cache" "apisummitredis" {
  name                = "redis-api-summit"
  location            = azurerm_resource_group.apisummitrg.location
  resource_group_name = azurerm_resource_group.apisummitrg.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {}
}


