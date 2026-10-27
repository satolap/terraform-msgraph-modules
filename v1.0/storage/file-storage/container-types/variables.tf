variable "billing_classification" {
  description = "Microsoft Graph billingClassification property."
  type        = string
  default     = null

  validation {
    condition     = var.billing_classification == null ? true : contains(["standard", "trial", "directToCustomer"], var.billing_classification)
    error_message = "billing_classification must be one of the documented enum values."
  }
}

variable "billing_status" {
  description = "Microsoft Graph billingStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.billing_status == null ? true : contains(["invalid", "valid"], var.billing_status)
    error_message = "billing_status must be one of the documented enum values."
  }
}

variable "name" {
  description = "The name of the fileStorageContainerType."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.fileStorageContainerType"
  nullable    = false
}

variable "owning_app_id" {
  description = "ID of the application that owns the fileStorageContainerType."
  type        = string
  default     = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type = object({
    odata_type                    = optional(string, "#microsoft.graph.fileStorageContainerTypeSettings")
    consumingTenantOverridables   = optional(string)
    isDiscoverabilityEnabled      = optional(bool)
    isItemVersioningEnabled       = optional(bool)
    isOfficeRestricted            = optional(bool)
    isSearchEnabled               = optional(bool)
    isSharingRestricted           = optional(bool)
    itemMajorVersionLimit         = optional(number)
    maxStoragePerContainerInBytes = optional(number)
    sharingCapability             = optional(string)
    urlTemplate                   = optional(string)
  })
  default = null

  validation {
    condition     = (var.settings == null ? true : alltrue([(var.settings["consumingTenantOverridables"] == null ? true : alltrue([(var.settings["consumingTenantOverridables"] == null ? true : try(alltrue([for value in split(",", var.settings["consumingTenantOverridables"]) : contains(["urltemplate", "isdiscoverabilityenabled", "issearchenabled", "isitemversioningenabled", "itemmajorversionlimit", "maxstoragepercontainerinbytes"], lower(trimspace(value)))]), false))])), (var.settings["sharingCapability"] == null ? true : alltrue([(var.settings["sharingCapability"] == null ? true : contains(["disabled", "externalUserSharingOnly", "externalUserAndGuestSharing", "existingExternalUserSharingOnly"], var.settings["sharingCapability"]))]))]))
    error_message = "settings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "etag", "expirationDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
