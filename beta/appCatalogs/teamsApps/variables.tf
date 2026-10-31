variable "appDefinitions" {
  description = "The details for each version of the app."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.teamsAppDefinition")
    allowedInstallationScopes = optional(string)
    authorization = optional(object({
      odata_type  = optional(string, "#microsoft.graph.teamsAppAuthorization")
      clientAppId = optional(string)
      requiredPermissionSet = optional(object({
        odata_type                  = optional(string, "#microsoft.graph.teamsAppPermissionSet")
        resourceSpecificPermissions = optional(any)
      }))
    }))
    azureADAppId = optional(string)
    bot          = optional(any)
    colorIcon    = optional(any)
    createdBy    = optional(any)
    dashboardCards = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsAppDashboardCardDefinition")
      contentSource = optional(object({
        odata_type       = optional(string, "#microsoft.graph.teamsAppDashboardCardContentSource")
        botConfiguration = optional(any)
        sourceType       = optional(string)
      }))
      defaultSize = optional(string)
      description = optional(string)
      displayName = optional(string)
      icon = optional(object({
        odata_type             = optional(string, "#microsoft.graph.teamsAppDashboardCardIcon")
        iconUrl                = optional(string)
        officeUIFabricIconName = optional(string)
      }))
      pickerGroupId = optional(string)
    })))
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    outlineIcon          = optional(any)
    publishingState      = optional(string)
    shortdescription     = optional(string)
    teamsAppId           = optional(string)
    version              = optional(string)
  }))
  default = null

  validation {
    condition     = (var.appDefinitions == null ? true : alltrue([alltrue([for input0 in var.appDefinitions : (input0 == null ? true : alltrue([(input0["allowedInstallationScopes"] == null ? true : alltrue([(input0["allowedInstallationScopes"] == null ? true : try(alltrue([for value in split(",", input0["allowedInstallationScopes"]) : contains(["team", "groupchat", "personal"], lower(trimspace(value)))]), false))])), (input0["dashboardCards"] == null ? true : alltrue([alltrue([for input2 in input0["dashboardCards"] : (input2 == null ? true : alltrue([(input2["contentSource"] == null ? true : alltrue([(input2["contentSource"]["sourceType"] == null ? true : alltrue([(input2["contentSource"]["sourceType"] == null ? true : contains(["bot"], input2["contentSource"]["sourceType"]))]))])), (input2["defaultSize"] == null ? true : alltrue([(input2["defaultSize"] == null ? true : contains(["medium", "large"], input2["defaultSize"]))]))]))])])), (input0["publishingState"] == null ? true : alltrue([(input0["publishingState"] == null ? true : contains(["submitted", "rejected", "published"], input0["publishingState"]))]))]))])]))
    error_message = "appDefinitions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "displayName" {
  description = "The name of the catalog app provided by the app developer in the Microsoft Teams zip app package."
  type        = string
  default     = null
}

variable "externalId" {
  description = "The ID of the catalog provided by the app developer in the Microsoft Teams zip app package."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsApp"
  nullable    = false
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["distributionMethod", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
