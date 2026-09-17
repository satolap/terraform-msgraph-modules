# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "businessRelationship"              = var.business_relationship
    "complianceRequirements"            = (var.compliance_requirements == null ? null : [for item0 in var.compliance_requirements : item0 if item0 != null])
    "contacts"                          = (var.contacts == null ? null : [for item0 in var.contacts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "email" = item0["email"], "name" = item0["name"], "notes" = item0["notes"], "phone" = item0["phone"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "managedServicesPlans"              = (var.managed_services_plans == null ? null : [for item0 in var.managed_services_plans : item0 if item0 != null])
    "note"                              = var.note
    "noteLastModifiedDateTime"          = var.note_last_modified_date_time
    "@odata.type"                       = var.odata_type
    "partnerRelationshipManagerUserIds" = (var.partner_relationship_manager_user_ids == null ? null : [for item0 in var.partner_relationship_manager_user_ids : item0 if item0 != null])
    "website"                           = var.website
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "tenantRelationships/managedTenants/tenantsCustomizedInformation"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
