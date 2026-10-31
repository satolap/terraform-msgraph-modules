variable "created" {
  description = "Creation metadata, including user and timestamp. Supports $orderby (dateTime property only). Supports $filter (ge, le, gt, lt) on the dateTime property. For example, $filter=created/dateTime ge 2023-01-01T00:00:00Z."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.auditInfo")
    by         = optional(string)
    dateTime   = optional(string)
  })
  default = null
}

variable "description" {
  description = "Optional description of the zone. Up to 255 characters. Supports $filter (eq, contains). For example, $filter=contains(description, 'production')."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Human-readable name of the zone. Up to 1,024 characters. Supports $filter (eq, contains), and $orderby. For example, $filter=displayName eq 'Production Zone' or $orderby=displayName asc."
  type        = string
  default     = null
}

variable "environments" {
  description = "Collection of attached environments. Supports $expand."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.security.environment")
    kind       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.environments == null ? true : alltrue([alltrue([for input0 in var.environments : (input0 == null ? true : alltrue([(input0["kind"] == null ? true : alltrue([(input0["kind"] == null ? true : contains(["azureSubscription", "awsOrganization", "awsAccount", "gcpOrganization", "gcpProject", "dockersHubOrganization", "devOpsConnection", "azureDevOpsOrganization", "gitHubOrganization", "gitLabGroup", "jFrogArtifactory"], input0["kind"]))]))]))])]))
    error_message = "environments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "modified" {
  description = "Last modification metadata, including user and timestamp. Supports $orderby (dateTime property only). Supports $filter (ge, le, gt, lt) on the dateTime property. For example, $orderby=modified/dateTime desc."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.auditInfo")
    by         = optional(string)
    dateTime   = optional(string)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.zone"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["aggregations", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
