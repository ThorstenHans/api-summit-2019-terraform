variable "environment_name" {
  type        = string
  default     = "development"
  description = "Environment Name"
}

variable "asp_size" {
  type        = string
  default     = "S1"
  description = "App Service Plan Size"
}

variable "custom_tags" {
  type        = map
  default     = {}
  description = "Custom Tags applied to every resource"
}

variable "deploy_s3_bucket" {
  type        = bool
  default     = true
  description = "Should S3 bucket be deployed or not"
}

variable "s3_bucket_count" {
  type        = number
  default     = 1
  description = "Number of S3 Buckets to deploy"
}
