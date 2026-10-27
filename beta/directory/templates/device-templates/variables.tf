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
    cloudLicensing = optional(object({
      odata_type = optional(string, "#microsoft.graph.cloudLicensing.deviceCloudLicensing")
      assignments = optional(list(object({
        odata_type             = optional(string, "#microsoft.graph.cloudLicensing.assignment")
        allotment              = optional(any)
        assignedTo             = optional(any)
        disabledServicePlanIds = optional(any)
      })))
      usageRights = optional(list(object({
        odata_type                = optional(string, "#microsoft.graph.cloudLicensing.usageRight")
        allotments                = optional(any)
        assignments               = optional(any)
        externalServiceIdentifier = optional(string)
      })))
      waitingMembers = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.cloudLicensing.waitingMember")
        allotment            = optional(any)
        assignedTo           = optional(any)
        waitingSinceDateTime = optional(string)
      })))
    }))
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
    deletedDateTime       = optional(string)
    deviceCategory        = optional(string)
    deviceId              = optional(string)
    deviceMetadata        = optional(string)
    deviceOwnership       = optional(string)
    deviceVersion         = optional(number)
    displayName           = optional(string)
    domainName            = optional(string)
    enrollmentProfileName = optional(string)
    enrollmentType        = optional(string)
    extensionAttributes = optional(object({
      odata_type           = optional(string, "#microsoft.graph.onPremisesExtensionAttributes")
      extensionAttribute1  = optional(string)
      extensionAttribute10 = optional(string)
      extensionAttribute11 = optional(string)
      extensionAttribute12 = optional(string)
      extensionAttribute13 = optional(string)
      extensionAttribute14 = optional(string)
      extensionAttribute15 = optional(string)
      extensionAttribute2  = optional(string)
      extensionAttribute3  = optional(string)
      extensionAttribute4  = optional(string)
      extensionAttribute5  = optional(string)
      extensionAttribute6  = optional(string)
      extensionAttribute7  = optional(string)
      extensionAttribute8  = optional(string)
      extensionAttribute9  = optional(string)
    }))
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
    transitiveMemberOf     = optional(any)
    usageRights = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.usageRight")
      catalogId         = optional(string)
      serviceIdentifier = optional(string)
      state             = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.device_instances == null ? true : alltrue([alltrue([for input0 in var.device_instances : (input0 == null ? true : alltrue([(input0["usageRights"] == null ? true : alltrue([alltrue([for input2 in input0["usageRights"] : (input2 == null ? true : alltrue([(input2["state"] == null ? true : alltrue([(input2["state"] == null ? true : contains(["active", "inactive", "warning", "suspended"], input2["state"]))]))]))])]))]))])]))
    error_message = "device_instances: nested required attributes must be non-null and enum values must be supported input members."
  }
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
