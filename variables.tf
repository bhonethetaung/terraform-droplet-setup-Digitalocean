variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "server_names" {
  description = "List of server names"
  type        = list(string)
}

variable "server_count" {
  description = "Number of servers to create"
  type        = number
  default     = 2
}

variable "server_tags" {
  description = "Server Tags"
  type        = list(string)
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "sgp1"
}

variable "size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image" {
  description = "Droplet image"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "startupfile" {
  description = "Startup File"
  type = string
}