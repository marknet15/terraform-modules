# Raspberrypi
variable "username" {
  description = "SSH username"
  type        = string
}

variable "password" {
  description = "Initial SSH user password"
  type        = string
  default     = "raspberry"
}

variable "new_password" {
  description = "New SSH user password"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key to add to the authorized_keys list"
  type        = string
}

variable "timezone" {
  description = "Timezone to set the host to"
  type        = string
}

variable "gateway" {
  description = "Network gateway router to use."
  type        = string
}

variable "nameserver" {
  description = "Name server to configure the host to use"
  type        = string
}

variable "nodes" {
  description = "Map of nodes to provision"
  type        = map(string)
}

variable "domain" {
  description = "DNS zone"
  type        = string
}

variable "subnet_mask" {
  description = "Network subnet mask"
  type        = string
}
