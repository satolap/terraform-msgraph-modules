# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "azureSubscriptionId"    = var.azure_subscription_id
    "azureTenantId"          = var.azure_tenant_id
    "createdDateTime"        = var.created_date_time
    "deploymentPackageUrl"   = var.deployment_package_url
    "destinationServiceName" = var.destination_service_name
    "isSigned"               = var.is_signed
    "lastModifiedDateTime"   = var.last_modified_date_time
    "manifest"               = var.manifest
    "name"                   = var.name
    "@odata.type"            = var.odata_type
    "permissionsRequired"    = var.permissions_required
    "platform"               = var.platform
    "policyName"             = var.policy_name
    "publisher"              = var.publisher
    "riskScore"              = var.risk_score
    "tags"                   = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "type"                   = var.type
    "vendorInformation"      = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/cloudAppSecurityProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
