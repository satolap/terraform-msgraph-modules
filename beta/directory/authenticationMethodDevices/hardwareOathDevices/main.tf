# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignTo"              = var.assignTo
    "assignedTo"            = var.assignedTo
    "displayName"           = var.displayName
    "hardwareOathDevices"   = (var.hardwareOathDevices == null ? null : [for item0 in var.hardwareOathDevices : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignTo" = item0["assignTo"], "assignedTo" = item0["assignedTo"], "displayName" = item0["displayName"], "hardwareOathDevices" = (item0["hardwareOathDevices"] == null ? null : [for item2 in item0["hardwareOathDevices"] : item2 if item2 != null]), "hashFunction" = item0["hashFunction"], "manufacturer" = item0["manufacturer"], "model" = item0["model"], "secretKey" = item0["secretKey"], "serialNumber" = item0["serialNumber"], "status" = item0["status"], "timeIntervalInSeconds" = item0["timeIntervalInSeconds"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hashFunction"          = var.hashFunction
    "manufacturer"          = var.manufacturer
    "model"                 = var.model
    "@odata.type"           = var.odata_type
    "secretKey"             = var.secretKey
    "serialNumber"          = var.serialNumber
    "status"                = var.status
    "timeIntervalInSeconds" = var.timeIntervalInSeconds
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "directory/authenticationMethodDevices/hardwareOathDevices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignTo", "hardwareOathDevices"], name)])]))))] } : null

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
