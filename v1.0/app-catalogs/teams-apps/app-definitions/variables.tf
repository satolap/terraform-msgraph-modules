variable "teams_app_id" {
  description = "The unique identifier of teamsApp"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teams_app_id)) > 0
    error_message = "teams_app_id must not be empty."
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

variable "bot" {
  description = "The details of the bot specified in the Teams app manifest."
  type        = any
  default     = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "description" {
  description = "Verbose description of the application."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the app provided by the app developer."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version number of the application."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
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

variable "publishing_state" {
  description = "The published status of a specific version of a Teams app. The possible values are:submitted—The specific version of the Teams app was submitted and is under review.published—The request to publish the specific version of the Teams app was approved by the admin and the app is published.rejected—The admin rejected the request to publish the specific version of the Teams app."
  type        = string
  default     = null

  validation {
    condition     = var.publishing_state == null ? true : contains(["submitted", "rejected", "published"], var.publishing_state)
    error_message = "publishing_state must be one of the documented enum values."
  }
}

variable "short_description" {
  description = "Short description of the application."
  type        = string
  default     = null
}

variable "teams_app_id_2" {
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
