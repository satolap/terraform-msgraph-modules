variable "catalogType" {
  description = "Whether the catalog is created by a user or entitlement management. The possible values are: userManaged, serviceDefault, serviceManaged, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.catalogType == null ? true : contains(["userManaged", "serviceDefault", "serviceManaged"], var.catalogType)
    error_message = "catalogType must be one of the documented enum values."
  }
}

variable "customWorkflowExtensions" {
  description = "Microsoft Graph customWorkflowExtensions property."
  type        = any
  default     = null
}

variable "description" {
  description = "The description of the access package catalog."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the access package catalog."
  type        = string
  default     = null
}

variable "isExternallyVisible" {
  description = "Whether the access packages in this catalog can be requested by users outside of the tenant."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageCatalog"
  nullable    = false
}

variable "resourceRoles" {
  description = "Microsoft Graph resourceRoles property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.accessPackageResourceRole")
    description  = optional(string)
    displayName  = optional(string)
    originId     = optional(string)
    originSystem = optional(string)
    resource     = optional(any)
    type         = optional(string)
  }))
  default = null

  validation {
    condition     = (var.resourceRoles == null ? true : alltrue([alltrue([for input0 in var.resourceRoles : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["active", "eligible", "application", "delegated"], input0["type"]))]))]))])]))
    error_message = "resourceRoles: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "resourceScopes" {
  description = "Microsoft Graph resourceScopes property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.accessPackageResourceScope")
    description  = optional(string)
    displayName  = optional(string)
    isRootScope  = optional(bool)
    originId     = optional(string)
    originSystem = optional(string)
    resource     = optional(any)
  }))
  default = null
}

variable "resources" {
  description = "Access package resources in this catalog."
  type        = any
  default     = null
}

variable "state" {
  description = "Has the value published if the access packages are available for management. The possible values are: unpublished, published, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unpublished", "published"], var.state)
    error_message = "state must be one of the documented enum values."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackages", "createdDateTime", "id", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
