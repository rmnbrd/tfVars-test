variable "region" {
  description = "AWS region to deploy resources into"
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name (must be lowercase, 3-63 chars)"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Allow bucket to be destroyed even if it contains objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}


