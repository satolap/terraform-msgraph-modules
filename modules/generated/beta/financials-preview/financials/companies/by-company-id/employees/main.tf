# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"              = var.address
    "birthDate"            = var.birth_date
    "displayName"          = var.display_name
    "email"                = var.email
    "employmentDate"       = var.employment_date
    "givenName"            = var.given_name
    "id"                   = var.id
    "jobTitle"             = var.job_title
    "lastModifiedDateTime" = var.last_modified_date_time
    "middleName"           = var.middle_name
    "mobilePhone"          = var.mobile_phone
    "number"               = var.number
    "@odata.type"          = var.odata_type
    "personalEmail"        = var.personal_email
    "phoneNumber"          = var.phone_number
    "picture"              = (var.picture == null ? null : [for item0 in var.picture : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "contentType" = item0["contentType"], "height" = item0["height"], "id" = item0["id"], "width" = item0["width"] } : key1 => value1 if value1 != null }) if item0 != null])
    "statisticsGroupCode"  = var.statistics_group_code
    "status"               = var.status
    "surname"              = var.surname
    "terminationDate"      = var.termination_date
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "financials/companies/${urlencode(var.company_id)}/employees"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
