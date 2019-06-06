variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

variable "resource_group" {
  description = "The name of the resource group in which to create the container instance and Cosmos DB instance."
  default     = "hello-porter"
}

variable "location" {
  description = "The location for the resource group in which to create the container instance and Cosmos DB instance."
  default     = "eastus"
}

variable "dns-prefix" {
  description = "DNS prefix for the public IP address of the container instance."
  default     = "hello-porter"
}

variable "container-image" {
  description = "Container image for the Azure Vote Flask application."
  default     = "microsoft/aci-helloworld"
}

variable "container-name" {
  description = "Container image for the Azure Vote Flask application."
  default     = "hello-porter"
}