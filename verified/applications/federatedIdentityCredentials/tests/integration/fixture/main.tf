terraform {
  required_version = ">= 1.11.0"
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
variable "enabled" {
  type    = bool
  default = true
}
variable "description" {
  type    = string
  default = "Created by terraform test; safe to delete"
}
# Persist a unique test name without adding a provider dependency.
resource "terraform_data" "suffix" {
  input = substr(uuid(), 0, 8)
  lifecycle {
    ignore_changes = [input]
  }
}
variable "subject" {
  type    = string
  default = "system:serviceaccount:tftest:initial"
}
module "application" {
  source       = "../../../.."
  display_name = "tftest-fic-${terraform_data.suffix.output}"
}
# No API permissions or service principal: these credentials cannot grant API access.
module "sibling" {
  source         = "../../.."
  application_id = module.application.id
  name           = "tftest-sibling"
  issuer         = "https://issuer.example.invalid"
  subject        = "system:serviceaccount:tftest:sibling"
}
module "credential" {
  source         = "../../.."
  count          = var.enabled ? 1 : 0
  application_id = module.application.id
  name           = "tftest-credential"
  issuer         = "https://issuer.example.invalid"
  subject        = var.subject
  description    = var.description
}
# Independent exact-item GET checks claims, rather than trusting the POST response.
data "msgraph_resource" "credential" {
  count                  = var.enabled ? 1 : 0
  url                    = "applications/${module.application.id}/federatedIdentityCredentials/${module.credential[0].id}"
  response_export_values = { credential = "@" }
  depends_on             = [module.credential]
}
# Collection GET permits checking absence without suppressing an unexpected HTTP error.
data "msgraph_resource" "credentials" {
  url                    = "applications/${module.application.id}/federatedIdentityCredentials"
  response_export_values = { credentials = "value" }
  depends_on             = [module.credential, module.sibling]
}
output "id" {
  value = var.enabled ? module.credential[0].id : null
}
output "credential" {
  value = var.enabled ? data.msgraph_resource.credential[0].output.credential : null
}
output "remaining_names" {
  value = sort([for item in data.msgraph_resource.credentials.output.credentials : item.name])
}
