# Terraform configuration – cart_deployment (Task 6 IaC)
# Creates a local file resource representing the cart deployment config
# (provider: local – no cloud credentials required)

terraform {
  required_version = ">= 1.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "local" {}

# ── Variables ───────────────────────────────────────────────────────────────

variable "deployment_name" {
  description = "Name of the cart deployment resource"
  type        = string
  default     = "cart_deployment"
}

variable "service_port" {
  description = "Port the shopping-cart service listens on"
  type        = number
  default     = 3000
}

# ── Resources ───────────────────────────────────────────────────────────────

resource "local_file" "cart_deployment" {
  filename        = "${path.module}/cart_deployment.json"
  file_permission = "0644"

  content = jsonencode({
    deployment_name = var.deployment_name
    service_port    = var.service_port
    image           = "retail-cart:1.0"
    replicas        = 2
    created_by      = "terraform"
    timestamp       = timestamp()
  })
}

# ── Outputs ─────────────────────────────────────────────────────────────────

output "deployment_file" {
  description = "Path to the generated cart deployment file"
  value       = local_file.cart_deployment.filename
}

output "service_port" {
  description = "Configured service port"
  value       = var.service_port
}
