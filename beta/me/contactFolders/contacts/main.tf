# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assistantName"         = var.assistantName
    "birthday"              = var.birthday
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "children"              = (var.children == null ? null : [for item0 in var.children : item0 if item0 != null])
    "companyName"           = var.companyName
    "createdDateTime"       = var.createdDateTime
    "department"            = var.department
    "displayName"           = var.displayName
    "emailAddresses"        = (var.emailAddresses == null ? null : [for item0 in var.emailAddresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "name" = item0["name"], "otherLabel" = item0["otherLabel"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "extensions"            = (var.extensions == null ? null : [for item0 in var.extensions : item0 if item0 != null])
    "fileAs"                = var.fileAs
    "flag"                  = (var.flag == null ? null : { for key0, value0 in { "@odata.type" = var.flag["odata_type"], "completedDateTime" = (var.flag["completedDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["completedDateTime"]["odata_type"], "dateTime" = var.flag["completedDateTime"]["dateTime"], "timeZone" = var.flag["completedDateTime"]["timeZone"] } : key1 => value1 if value1 != null }), "dueDateTime" = (var.flag["dueDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["dueDateTime"]["odata_type"], "dateTime" = var.flag["dueDateTime"]["dateTime"], "timeZone" = var.flag["dueDateTime"]["timeZone"] } : key1 => value1 if value1 != null }), "flagStatus" = var.flag["flagStatus"], "startDateTime" = (var.flag["startDateTime"] == null ? null : { for key1, value1 in { "@odata.type" = var.flag["startDateTime"]["odata_type"], "dateTime" = var.flag["startDateTime"]["dateTime"], "timeZone" = var.flag["startDateTime"]["timeZone"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "gender"                = var.gender
    "generation"            = var.generation
    "givenName"             = var.givenName
    "imAddresses"           = (var.imAddresses == null ? null : [for item0 in var.imAddresses : item0 if item0 != null])
    "initials"              = var.initials
    "isFavorite"            = var.isFavorite
    "jobTitle"              = var.jobTitle
    "lastModifiedDateTime"  = var.lastModifiedDateTime
    "manager"               = var.manager
    "middleName"            = var.middleName
    "nickName"              = var.nickName
    "@odata.type"           = var.odata_type
    "officeLocation"        = var.officeLocation
    "parentFolderId"        = var.parentFolderId
    "personalNotes"         = var.personalNotes
    "phones"                = (var.phones == null ? null : [for item0 in var.phones : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "number" = item0["number"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "photo"                 = var.photo
    "postalAddresses"       = (var.postalAddresses == null ? null : [for item0 in var.postalAddresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "city" = item0["city"], "countryOrRegion" = item0["countryOrRegion"], "postOfficeBox" = item0["postOfficeBox"], "postalCode" = item0["postalCode"], "state" = item0["state"], "street" = item0["street"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "primaryEmailAddress"   = var.primaryEmailAddress
    "profession"            = var.profession
    "secondaryEmailAddress" = var.secondaryEmailAddress
    "spouseName"            = var.spouseName
    "surname"               = var.surname
    "tertiaryEmailAddress"  = var.tertiaryEmailAddress
    "title"                 = var.title
    "websites"              = (var.websites == null ? null : [for item0 in var.websites : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "displayName" = item0["displayName"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "weddingAnniversary"    = var.weddingAnniversary
    "yomiCompanyName"       = var.yomiCompanyName
    "yomiGivenName"         = var.yomiGivenName
    "yomiSurname"           = var.yomiSurname
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "me/contactFolders/${urlencode(var.contactFolder-id)}/contacts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["extensions", "photo"], name)])]))))] } : null

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
