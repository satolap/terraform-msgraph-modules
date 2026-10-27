variable "access_package_custom_workflow_extensions" {
  description = "The attributes of a logic app, which can be called at various stages of an access package request and assignment cycle."
  type        = any
  default     = null
}

variable "access_package_resource_scopes" {
  description = "Microsoft Graph accessPackageResourceScopes property."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.accessPackageResourceScope")
    accessPackageResource = optional(any)
    description           = optional(string)
    displayName           = optional(string)
    isRootScope           = optional(bool)
    originId              = optional(string)
    originSystem          = optional(string)
    roleOriginId          = optional(string)
    url                   = optional(string)
  }))
  default = null
}

variable "access_package_resources" {
  description = "Microsoft Graph accessPackageResources property."
  type        = any
  default     = null
}

variable "catalog_status" {
  description = "Has the value Published if the access packages are available for management."
  type        = string
  default     = null
}

variable "catalog_type" {
  description = "One of UserManaged or ServiceDefault."
  type        = string
  default     = null
}

variable "custom_access_package_workflow_extensions" {
  description = "Microsoft Graph customAccessPackageWorkflowExtensions property."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.customAccessPackageWorkflowExtension")
    authenticationConfiguration = optional(any)
    clientConfiguration = optional(object({
      odata_type            = optional(string, "#microsoft.graph.customExtensionClientConfiguration")
      maximumRetries        = optional(number)
      timeoutInMilliseconds = optional(number)
    }))
    description           = optional(string)
    displayName           = optional(string)
    endpointConfiguration = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The description of the access package catalog."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the access package catalog. Supports $filter (eq, contains)."
  type        = string
  default     = null
}

variable "is_externally_visible" {
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

variable "privilege_level" {
  description = "Microsoft Graph privilegeLevel property."
  type        = string
  default     = null

  validation {
    condition     = var.privilege_level == null ? true : contains(["standard", "privileged"], var.privilege_level)
    error_message = "privilege_level must be one of the documented enum values."
  }
}

variable "unique_name" {
  description = "Microsoft Graph uniqueName property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackageResourceRoles", "accessPackages", "createdBy", "createdDateTime", "id", "modifiedBy", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
