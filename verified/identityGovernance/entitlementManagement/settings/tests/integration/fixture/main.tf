terraform {
  required_version = ">= 1.11.0"
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
data "msgraph_resource" "settings" {
  url                    = "identityGovernance/entitlementManagement/settings"
  response_export_values = { settings = "@" }
}
output "settings" {
  value = data.msgraph_resource.settings.output.settings
}
