variable "name" {
  description = "Name of the container registry to create"
  type        = string
  nullable    = false
}

variable "subscription_tier" {
  description = "Tier of the container registry to create"
  type        = string
  default     = "starter"
}