variable "apiConnectorConfiguration" {
  description = "Configuration for enabling an API connector for use as part of the user flow. You can only obtain the value of this object using Get userFlowApiConnectorConfiguration."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.userFlowApiConnectorConfiguration")
    postAttributeCollection = optional(any)
    postFederationSignup    = optional(any)
    preTokenIssuance        = optional(any)
  })
  default = null
}

variable "defaultLanguageTag" {
  description = "Indicates the default language of the b2cIdentityUserFlow that is used when no ui_locale tag is specified in the request. This field is RFC 5646 compliant."
  type        = string
  default     = null
}

variable "identityProviders" {
  description = "The identity providers included in the user flow."
  type        = any
  default     = null
  sensitive   = true
}

variable "isLanguageCustomizationEnabled" {
  description = "The property that determines whether language customization is enabled within the B2C user flow. Language customization is not enabled by default for B2C user flows."
  type        = bool
  default     = null
}

variable "languages" {
  description = "The languages supported for customization within the user flow. Language customization is not enabled by default in B2C user flows."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userFlowLanguageConfiguration")
    defaultPages = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")
    })))
    isEnabled = optional(bool)
    overridesPages = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.b2cIdentityUserFlow"
  nullable    = false
}

variable "userAttributeAssignments" {
  description = "The user attribute assignments included in the user flow."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.identityUserFlowAttributeAssignment")
    displayName          = optional(string)
    isOptional           = optional(bool)
    requiresVerification = optional(bool)
    userAttribute        = optional(any)
    userAttributeValues = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.userAttributeValuesItem")
      isDefault  = optional(bool)
      name       = optional(string)
      value      = optional(string)
    })))
    userInputType = optional(string)
  }))
  default = null

  validation {
    condition     = (var.userAttributeAssignments == null ? true : alltrue([alltrue([for input0 in var.userAttributeAssignments : (input0 == null ? true : alltrue([(input0["userInputType"] == null ? true : alltrue([(input0["userInputType"] == null ? true : contains(["textBox", "dateTimeDropdown", "radioSingleSelect", "dropdownSingleSelect", "emailBox", "checkboxMultiSelect"], input0["userInputType"]))]))]))])]))
    error_message = "userAttributeAssignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "userFlowIdentityProviders" {
  description = "The identity providers included in the user flow."
  type        = any
  default     = null
}

variable "userFlowType" {
  description = "Microsoft Graph userFlowType property."
  type        = string
  default     = null

  validation {
    condition     = var.userFlowType == null ? true : contains(["signUp", "signIn", "signUpOrSignIn", "passwordReset", "profileUpdate", "resourceOwner"], var.userFlowType)
    error_message = "userFlowType must be one of the documented enum values."
  }
}

variable "userFlowTypeVersion" {
  description = "Microsoft Graph userFlowTypeVersion property."
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
