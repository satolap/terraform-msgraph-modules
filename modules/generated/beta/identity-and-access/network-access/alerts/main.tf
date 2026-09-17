# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actions"               = (var.actions == null ? null : [for item0 in var.actions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionLink" = item0["actionLink"], "actionText" = item0["actionText"] } : key1 => value1 if value1 != null }) if item0 != null])
    "alertType"             = var.alert_type
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "componentName"         = var.component_name
    "creationDateTime"      = var.creation_date_time
    "description"           = var.description
    "detectionTechnology"   = var.detection_technology
    "displayName"           = var.display_name
    "extendedProperties"    = var.extended_properties
    "firstActivityDateTime" = var.first_activity_date_time
    "isPreview"             = var.is_preview
    "lastActivityDateTime"  = var.last_activity_date_time
    "@odata.type"           = var.odata_type
    "policy"                = var.policy
    "productName"           = var.product_name
    "relatedResources"      = (var.related_resources == null ? null : [for item0 in var.related_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "severity"              = var.severity
    "subTechniques"         = (var.sub_techniques == null ? null : [for item0 in var.sub_techniques : item0 if item0 != null])
    "techniques"            = (var.techniques == null ? null : [for item0 in var.techniques : item0 if item0 != null])
    "vendorName"            = var.vendor_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/alerts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
