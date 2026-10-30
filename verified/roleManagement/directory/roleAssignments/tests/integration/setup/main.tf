terraform {
  required_version = ">= 1.11.0"
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
resource "terraform_data" "suffix" {
  input = substr(uuid(), 0, 8)
  lifecycle {
    ignore_changes = [input]
  }
}
module "reader_role" {
  source      = "../../../../roleDefinitions"
  displayName = "tftest-reader-${terraform_data.suffix.output}"
  rolePermissions = [{
    allowedResourceActions = ["microsoft.directory/applications/standard/read"]
  }]
}
output "role_definition_id" {
  value = module.reader_role.id
}
