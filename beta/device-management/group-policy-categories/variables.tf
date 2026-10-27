variable "children" {
  description = "The children categories"
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.groupPolicyCategory")
    children       = optional(any)
    definitionFile = optional(any)
    definitions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.groupPolicyDefinition")
      category                  = optional(any)
      categoryPath              = optional(string)
      classType                 = optional(string)
      definitionFile            = optional(any)
      displayName               = optional(string)
      explainText               = optional(string)
      groupPolicyCategoryId     = optional(string)
      hasRelatedDefinitions     = optional(bool)
      lastModifiedDateTime      = optional(string)
      minDeviceCspVersion       = optional(string)
      minUserCspVersion         = optional(string)
      nextVersionDefinition     = optional(any)
      policyType                = optional(string)
      presentations             = optional(any)
      previousVersionDefinition = optional(any)
      supportedOn               = optional(string)
      version                   = optional(string)
    })))
    displayName          = optional(string)
    ingestionSource      = optional(string)
    isRoot               = optional(bool)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
  }))
  default = null

  validation {
    condition     = (var.children == null ? true : alltrue([alltrue([for input0 in var.children : (input0 == null ? true : alltrue([(input0["definitions"] == null ? true : alltrue([alltrue([for input2 in input0["definitions"] : (input2 == null ? true : alltrue([(input2["classType"] == null ? true : alltrue([(input2["classType"] == null ? true : contains(["user", "machine"], input2["classType"]))])), (input2["policyType"] == null ? true : alltrue([(input2["policyType"] == null ? true : contains(["admxBacked", "admxIngested"], input2["policyType"]))]))]))])])), (input0["ingestionSource"] == null ? true : alltrue([(input0["ingestionSource"] == null ? true : contains(["unknown", "custom", "builtIn"], input0["ingestionSource"]))]))]))])]))
    error_message = "children: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "definition_file" {
  description = "The id of the definition file the category came from"
  type        = any
  default     = null
}

variable "definitions" {
  description = "The immediate GroupPolicyDefinition children of the category"
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.groupPolicyDefinition")
    category                  = optional(any)
    categoryPath              = optional(string)
    classType                 = optional(string)
    definitionFile            = optional(any)
    displayName               = optional(string)
    explainText               = optional(string)
    groupPolicyCategoryId     = optional(string)
    hasRelatedDefinitions     = optional(bool)
    lastModifiedDateTime      = optional(string)
    minDeviceCspVersion       = optional(string)
    minUserCspVersion         = optional(string)
    nextVersionDefinition     = optional(any)
    policyType                = optional(string)
    presentations             = optional(any)
    previousVersionDefinition = optional(any)
    supportedOn               = optional(string)
    version                   = optional(string)
  }))
  default = null

  validation {
    condition     = (var.definitions == null ? true : alltrue([alltrue([for input0 in var.definitions : (input0 == null ? true : alltrue([(input0["classType"] == null ? true : alltrue([(input0["classType"] == null ? true : contains(["user", "machine"], input0["classType"]))])), (input0["policyType"] == null ? true : alltrue([(input0["policyType"] == null ? true : contains(["admxBacked", "admxIngested"], input0["policyType"]))]))]))])]))
    error_message = "definitions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "display_name" {
  description = "The string id of the category's display name"
  type        = string
  default     = null
}

variable "ingestion_source" {
  description = "Category Ingestion source"
  type        = string
  default     = null

  validation {
    condition     = var.ingestion_source == null ? true : contains(["unknown", "custom", "builtIn"], var.ingestion_source)
    error_message = "ingestion_source must be one of the documented enum values."
  }
}

variable "is_root" {
  description = "Defines if the category is a root category"
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyCategory"
  nullable    = false
}

variable "parent" {
  description = "The parent category"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
