variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "device_authority" {
  description = "A tenant-defined name for the party that's responsible for provisioning and managing devices on the Microsoft Entra tenant. For example, Tailwind Traders (the manufacturer) makes security cameras that are installed in customer buildings and managed by Lakeshore Retail (the device authority). This value is provided to the customer by the device authority (manufacturer or reseller)."
  type        = string
  default     = null
}

variable "device_instances" {
  description = "Collection of device objects created based on this template."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.device")
    accountEnabled   = optional(bool)
    alternativeNames = optional(list(string))
    alternativeSecurityIds = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.alternativeSecurityId")
      identityProvider = optional(string)
      key              = optional(string)
      type             = optional(number)
    })))
    commands = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.command")
      appServiceName    = optional(string)
      error             = optional(string)
      packageFamilyName = optional(string)
      payload           = optional(any)
      permissionTicket  = optional(string)
      postBackUri       = optional(string)
      responsepayload   = optional(any)
      status            = optional(string)
      type              = optional(string)
    })))
    deletedDateTime        = optional(string)
    deviceCategory         = optional(string)
    deviceId               = optional(string)
    deviceMetadata         = optional(string)
    deviceOwnership        = optional(string)
    deviceVersion          = optional(number)
    displayName            = optional(string)
    domainName             = optional(string)
    enrollmentProfileName  = optional(string)
    enrollmentType         = optional(string)
    extensionAttributes    = optional(any)
    hostnames              = optional(list(string))
    isManaged              = optional(bool)
    isRooted               = optional(bool)
    kind                   = optional(string)
    managementType         = optional(string)
    name                   = optional(string)
    operatingSystem        = optional(string)
    operatingSystemVersion = optional(string)
    physicalIds            = optional(list(string))
    platform               = optional(string)
    profileType            = optional(string)
    status                 = optional(string)
    systemLabels           = optional(list(string))
    transitiveMemberOf = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.directoryObject")
      deletedDateTime = optional(string)
    })))
    usageRights = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.usageRight")
      catalogId         = optional(string)
      serviceIdentifier = optional(string)
      state             = optional(string)
    })))
  }))
  default = null
}

variable "manufacturer" {
  description = "Manufacturer name."
  type        = string
  default     = null
}

variable "model" {
  description = "Model name."
  type        = string
  default     = null
}

variable "mutual_tls_oauth_configuration_id" {
  description = "Object ID of the mutualTlsOauthConfiguration. This value isn't required if self-signed certificates are used. This value is provided to the customer by the device authority (manufacturer or reseller)."
  type        = string
  default     = null
}

variable "mutual_tls_oauth_configuration_tenant_id" {
  description = "ID (tenant ID for device authority) of the tenant that contains the mutualTlsOauthConfiguration. This value isn't required if self-signed certificates are used. This value is provided to the customer by the device authority (manufacturer or reseller)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceTemplate"
  nullable    = false
}

variable "operating_system" {
  description = "Operating system type. Supports $filter (eq, in)."
  type        = string
  default     = null
}

variable "owners" {
  description = "Collection of directory objects that can manage the device template and the related deviceInstances. Owners can be represented as service principals, users, or applications. An owner has full privileges over the device template and doesn't require other administrator roles to create, update, or delete devices from this template, as well as to add or remove template owners. There can be a maximum of 100 owners on a device template.  Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
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
