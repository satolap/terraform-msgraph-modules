variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.cloudPcAgentPool"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "assignments" {
  description = "The collection of assignments that grant user or service principal identities access to this pool."
  type        = any
  default     = null
}

variable "cloud_pc_configuration" {
  description = "Microsoft Graph cloudPcConfiguration property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.cloudPcConfiguration")
    imageId    = optional(string)
    imageType  = optional(string)
    osLocale   = optional(string)
  })
  default = null

  validation {
    condition     = (var.cloud_pc_configuration == null ? true : alltrue([(var.cloud_pc_configuration["imageType"] == null ? true : alltrue([(var.cloud_pc_configuration["imageType"] == null ? true : contains(["gallery", "custom"], var.cloud_pc_configuration["imageType"]))]))]))
    error_message = "cloud_pc_configuration: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "The description of the pool. The maximum length is 512 characters."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the pool. The name is unique across Cloud PC pools in an organization. The maximum length is 60 characters."
  type        = string
  default     = null
}

variable "network_configuration" {
  description = "Microsoft Graph networkConfiguration property."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
