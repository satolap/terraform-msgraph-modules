variable "description" {
  description = "The description of this rubric."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.educationItemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null

  validation {
    condition     = (var.description == null ? true : alltrue([(var.description["contentType"] == null ? true : alltrue([(var.description["contentType"] == null ? true : contains(["text", "html"], var.description["contentType"]))]))]))
    error_message = "description: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "display_name" {
  description = "The name of this rubric."
  type        = string
  default     = null
}

variable "grading" {
  description = "The grading type of this rubric. You can use null for a no-points rubric or educationAssignmentPointsGradeType for a points rubric."
  type        = any
  default     = null
}

variable "levels" {
  description = "The collection of levels making up this rubric."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.rubricLevel")
    description = optional(object({
      odata_type  = optional(string, "#microsoft.graph.educationItemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    displayName = optional(string)
    grading     = optional(any)
    levelId     = optional(string)
  }))
  default = null

  validation {
    condition     = (var.levels == null ? true : alltrue([alltrue([for input0 in var.levels : (input0 == null ? true : alltrue([(input0["description"] == null ? true : alltrue([(input0["description"]["contentType"] == null ? true : alltrue([(input0["description"]["contentType"] == null ? true : contains(["text", "html"], input0["description"]["contentType"]))]))]))]))])]))
    error_message = "levels: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationRubric"
  nullable    = false
}

variable "qualities" {
  description = "The collection of qualities making up this rubric."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.rubricQuality")
    criteria = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.rubricCriterion")
      description = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationItemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
    })))
    description = optional(object({
      odata_type  = optional(string, "#microsoft.graph.educationItemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    displayName = optional(string)
    qualityId   = optional(string)
    weight      = optional(any)
  }))
  default = null

  validation {
    condition     = (var.qualities == null ? true : alltrue([alltrue([for input0 in var.qualities : (input0 == null ? true : alltrue([(input0["criteria"] == null ? true : alltrue([alltrue([for input2 in input0["criteria"] : (input2 == null ? true : alltrue([(input2["description"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : contains(["text", "html"], input2["description"]["contentType"]))]))]))]))])])), (input0["description"] == null ? true : alltrue([(input0["description"]["contentType"] == null ? true : alltrue([(input0["description"]["contentType"] == null ? true : contains(["text", "html"], input0["description"]["contentType"]))]))]))]))])]))
    error_message = "qualities: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
