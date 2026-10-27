# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "email"            = var.email
    "identity"         = var.identity
    "@odata.type"      = var.odata_type
    "presenterDetails" = (var.presenter_details == null ? null : { for key0, value0 in { "@odata.type" = var.presenter_details["odata_type"], "bio" = (var.presenter_details["bio"] == null ? null : { for key1, value1 in { "@odata.type" = var.presenter_details["bio"]["odata_type"], "content" = var.presenter_details["bio"]["content"], "contentType" = var.presenter_details["bio"]["contentType"] } : key1 => value1 if value1 != null }), "company" = var.presenter_details["company"], "jobTitle" = var.presenter_details["jobTitle"], "linkedInProfileWebUrl" = var.presenter_details["linkedInProfileWebUrl"], "personalSiteWebUrl" = var.presenter_details["personalSiteWebUrl"], "photo" = var.presenter_details["photo"], "twitterProfileWebUrl" = var.presenter_details["twitterProfileWebUrl"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "solutions/virtualEvents/webinars/${urlencode(var.virtual_event_webinar_id)}/presenters"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
