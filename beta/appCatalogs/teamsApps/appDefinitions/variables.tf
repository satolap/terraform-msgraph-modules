variable "teamsApp-id" {
  description = "The unique identifier of teamsApp"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teamsApp-id)) > 0
    error_message = "teamsApp-id must not be empty."
  }
}

variable "allowedInstallationScopes" {
  description = "A collection of scopes where the Teams app can be installed. The possible values are:team—Indicates that the Teams app can be installed within a team and is authorized to access that team's data. groupChat—Indicates that the Teams app can be installed within a group chat and is authorized to access that group chat's data. personal—Indicates that the Teams app can be installed in the personal scope of a user and is authorized to access that user's data."
  type        = string
  default     = null

  validation {
    condition     = var.allowedInstallationScopes == null ? true : try(alltrue([for value in split(",", var.allowedInstallationScopes) : contains(["team", "groupchat", "personal"], lower(trimspace(value)))]), false)
    error_message = "allowedInstallationScopes must be one or more of the documented enum values, separated by commas."
  }
}

variable "authorization" {
  description = "Authorization requirements specified in the Teams app manifest."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.teamsAppAuthorization")
    clientAppId = optional(string)
    requiredPermissionSet = optional(object({
      odata_type = optional(string, "#microsoft.graph.teamsAppPermissionSet")
      resourceSpecificPermissions = optional(list(object({
        odata_type      = optional(string, "#microsoft.graph.teamsAppResourceSpecificPermission")
        permissionType  = optional(string)
        permissionValue = optional(string)
      })))
    }))
  })
  default = null

  validation {
    condition     = (var.authorization == null ? true : alltrue([(var.authorization["requiredPermissionSet"] == null ? true : alltrue([(var.authorization["requiredPermissionSet"]["resourceSpecificPermissions"] == null ? true : alltrue([alltrue([for input2 in var.authorization["requiredPermissionSet"]["resourceSpecificPermissions"] : (input2 == null ? true : alltrue([(input2["permissionType"] == null ? true : alltrue([(input2["permissionType"] == null ? true : contains(["delegated", "application"], input2["permissionType"]))]))]))])]))]))]))
    error_message = "authorization: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "azureADAppId" {
  description = "The WebApplicationInfo.Id from the Teams app manifest."
  type        = string
  default     = null
}

variable "bot" {
  description = "The details of the bot specified in the Teams app manifest."
  type        = any
  default     = null
}

variable "colorIcon" {
  description = "The color version of the Teams app's icon."
  type        = any
  default     = null
}

variable "createdBy" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "dashboardCards" {
  description = "Dashboard cards specified in the Teams app manifest."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsAppDashboardCardDefinition")
    contentSource = optional(object({
      odata_type = optional(string, "#microsoft.graph.teamsAppDashboardCardContentSource")
      botConfiguration = optional(object({
        odata_type = optional(string, "#microsoft.graph.teamsAppDashboardCardBotConfiguration")
        botId      = optional(string)
      }))
      sourceType = optional(string)
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
  }))
  default = null

  validation {
    condition     = (var.dashboardCards == null ? true : alltrue([alltrue([for input0 in var.dashboardCards : (input0 == null ? true : alltrue([(input0["contentSource"] == null ? true : alltrue([(input0["contentSource"]["sourceType"] == null ? true : alltrue([(input0["contentSource"]["sourceType"] == null ? true : contains(["bot"], input0["contentSource"]["sourceType"]))]))])), (input0["defaultSize"] == null ? true : alltrue([(input0["defaultSize"] == null ? true : contains(["medium", "large"], input0["defaultSize"]))]))]))])]))
    error_message = "dashboardCards: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The name of the app provided by the app developer."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version number of the application."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAppDefinition"
  nullable    = false
}

variable "outlineIcon" {
  description = "The outline version of the Teams app's icon."
  type        = any
  default     = null
}

variable "publishingState" {
  description = "The published status of a specific version of a Teams app. The possible values are:submitted—The specific version of the Teams app has been submitted and is under review. published - The request to publish the specific version of the Teams app has been approved by the admin and the app is published. rejected - The request to publish the specific version of the Teams app was rejected by the admin."
  type        = string
  default     = null

  validation {
    condition     = var.publishingState == null ? true : contains(["submitted", "rejected", "published"], var.publishingState)
    error_message = "publishingState must be one of the documented enum values."
  }
}

variable "shortdescription" {
  description = "Microsoft Graph shortdescription property."
  type        = string
  default     = null
}

variable "teamsAppId" {
  description = "The ID from the Teams app manifest."
  type        = string
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
