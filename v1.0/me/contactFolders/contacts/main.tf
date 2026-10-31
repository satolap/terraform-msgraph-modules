# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assistantName"         = var.assistantName
    "birthday"              = var.birthday
    "businessAddress"       = (var.businessAddress == null ? null : { for key0, value0 in { "@odata.type" = var.businessAddress["odata_type"], "city" = var.businessAddress["city"], "countryOrRegion" = var.businessAddress["countryOrRegion"], "postalCode" = var.businessAddress["postalCode"], "state" = var.businessAddress["state"], "street" = var.businessAddress["street"] } : key0 => value0 if value0 != null })
    "businessHomePage"      = var.businessHomePage
    "businessPhones"        = (var.businessPhones == null ? null : [for item0 in var.businessPhones : item0 if item0 != null])
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "children"              = (var.children == null ? null : [for item0 in var.children : item0 if item0 != null])
    "companyName"           = var.companyName
    "createdDateTime"       = var.createdDateTime
    "department"            = var.department
    "displayName"           = var.displayName
    "emailAddresses"        = (var.emailAddresses == null ? null : [for item0 in var.emailAddresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "fileAs"                = var.fileAs
    "generation"            = var.generation
    "givenName"             = var.givenName
    "homeAddress"           = (var.homeAddress == null ? null : { for key0, value0 in { "@odata.type" = var.homeAddress["odata_type"], "city" = var.homeAddress["city"], "countryOrRegion" = var.homeAddress["countryOrRegion"], "postalCode" = var.homeAddress["postalCode"], "state" = var.homeAddress["state"], "street" = var.homeAddress["street"] } : key0 => value0 if value0 != null })
    "homePhones"            = (var.homePhones == null ? null : [for item0 in var.homePhones : item0 if item0 != null])
    "imAddresses"           = (var.imAddresses == null ? null : [for item0 in var.imAddresses : item0 if item0 != null])
    "initials"              = var.initials
    "jobTitle"              = var.jobTitle
    "lastModifiedDateTime"  = var.lastModifiedDateTime
    "manager"               = var.manager
    "middleName"            = var.middleName
    "mobilePhone"           = var.mobilePhone
    "nickName"              = var.nickName
    "@odata.type"           = var.odata_type
    "officeLocation"        = var.officeLocation
    "otherAddress"          = (var.otherAddress == null ? null : { for key0, value0 in { "@odata.type" = var.otherAddress["odata_type"], "city" = var.otherAddress["city"], "countryOrRegion" = var.otherAddress["countryOrRegion"], "postalCode" = var.otherAddress["postalCode"], "state" = var.otherAddress["state"], "street" = var.otherAddress["street"] } : key0 => value0 if value0 != null })
    "parentFolderId"        = var.parentFolderId
    "personalNotes"         = var.personalNotes
    "photo"                 = var.photo
    "primaryEmailAddress"   = (var.primaryEmailAddress == null ? null : { for key0, value0 in { "@odata.type" = var.primaryEmailAddress["odata_type"], "address" = var.primaryEmailAddress["address"], "name" = var.primaryEmailAddress["name"] } : key0 => value0 if value0 != null })
    "profession"            = var.profession
    "secondaryEmailAddress" = (var.secondaryEmailAddress == null ? null : { for key0, value0 in { "@odata.type" = var.secondaryEmailAddress["odata_type"], "address" = var.secondaryEmailAddress["address"], "name" = var.secondaryEmailAddress["name"] } : key0 => value0 if value0 != null })
    "spouseName"            = var.spouseName
    "surname"               = var.surname
    "tertiaryEmailAddress"  = (var.tertiaryEmailAddress == null ? null : { for key0, value0 in { "@odata.type" = var.tertiaryEmailAddress["odata_type"], "address" = var.tertiaryEmailAddress["address"], "name" = var.tertiaryEmailAddress["name"] } : key0 => value0 if value0 != null })
    "title"                 = var.title
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
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["photo"], name)])]))))] } : null

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
