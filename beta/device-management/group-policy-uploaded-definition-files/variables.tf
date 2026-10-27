variable "content" {
  description = "The contents of the uploaded ADMX file."
  type        = string
  default     = null
}

variable "default_language_code" {
  description = "The default language of the uploaded ADMX file."
  type        = string
  default     = null
}

variable "definitions" {
  description = "The group policy definitions associated with the file."
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

variable "description" {
  description = "The localized description of the policy settings in the ADMX file. The default value is empty."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The localized friendly name of the ADMX file."
  type        = string
  default     = null
}

variable "file_name" {
  description = "The file name of the ADMX file without the path. For example: edge.admx"
  type        = string
  default     = null
}

variable "group_policy_operations" {
  description = "The list of operations on the uploaded ADMX file."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyOperation")
    lastModifiedDateTime = optional(string)
    operationStatus      = optional(string)
    operationType        = optional(string)
    statusDetails        = optional(string)
  }))
  default = null

  validation {
    condition     = (var.group_policy_operations == null ? true : alltrue([alltrue([for input0 in var.group_policy_operations : (input0 == null ? true : alltrue([(input0["operationStatus"] == null ? true : alltrue([(input0["operationStatus"] == null ? true : contains(["unknown", "inProgress", "success", "failed"], input0["operationStatus"]))])), (input0["operationType"] == null ? true : alltrue([(input0["operationType"] == null ? true : contains(["none", "upload", "uploadNewVersion", "addLanguageFiles", "removeLanguageFiles", "updateLanguageFiles", "remove"], input0["operationType"]))]))]))])]))
    error_message = "group_policy_operations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "group_policy_uploaded_language_files" {
  description = "The list of ADML files associated with the uploaded ADMX file."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyUploadedLanguageFile")
    content              = optional(string)
    fileName             = optional(string)
    id                   = optional(string)
    languageCode         = optional(string)
    lastModifiedDateTime = optional(string)
  }))
  default = null
}

variable "language_codes" {
  description = "The supported language codes for the ADMX file."
  type        = list(string)
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
  default     = "#microsoft.graph.groupPolicyUploadedDefinitionFile"
  nullable    = false
}

variable "policy_type" {
  description = "Type of Group Policy File or Definition."
  type        = string
  default     = null

  validation {
    condition     = var.policy_type == null ? true : contains(["admxBacked", "admxIngested"], var.policy_type)
    error_message = "policy_type must be one of the documented enum values."
  }
}

variable "revision" {
  description = "The revision version associated with the file."
  type        = string
  default     = null
}

variable "status" {
  description = "Type of Group Policy uploaded definition file status."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["none", "uploadInProgress", "available", "assigned", "removalInProgress", "uploadFailed", "removalFailed"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "target_namespace" {
  description = "Specifies the URI used to identify the namespace within the ADMX file."
  type        = string
  default     = null
}

variable "target_prefix" {
  description = "Specifies the logical name that refers to the namespace within the ADMX file."
  type        = string
  default     = null
}

variable "upload_date_time" {
  description = "The uploaded time of the uploaded ADMX file."
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
