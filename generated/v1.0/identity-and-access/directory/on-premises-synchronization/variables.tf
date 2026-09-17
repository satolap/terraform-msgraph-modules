variable "configuration" {
  description = "Consists of configurations that can be fine-tuned and impact the on-premises directory synchronization process for a tenant. Nullable."
  type        = any
  default     = null
}

variable "features" {
  description = "Microsoft Graph features property."
  type = object({
    odata_type                                           = optional(string, "#microsoft.graph.onPremisesDirectorySynchronizationFeature")
    allowOnPremUpdateOfOnPremisesObjectIdentifierEnabled = optional(bool)
    blockCloudObjectTakeoverThroughHardMatchEnabled      = optional(bool)
    blockSoftMatchEnabled                                = optional(bool)
    bypassDirSyncOverridesEnabled                        = optional(bool)
    cloudPasswordPolicyForPasswordSyncedUsersEnabled     = optional(bool)
    concurrentCredentialUpdateEnabled                    = optional(bool)
    concurrentOrgIdProvisioningEnabled                   = optional(bool)
    deviceWritebackEnabled                               = optional(bool)
    directoryExtensionsEnabled                           = optional(bool)
    fopeConflictResolutionEnabled                        = optional(bool)
    groupWriteBackEnabled                                = optional(bool)
    passwordSyncEnabled                                  = optional(bool)
    passwordWritebackEnabled                             = optional(bool)
    quarantineUponProxyAddressesConflictEnabled          = optional(bool)
    quarantineUponUpnConflictEnabled                     = optional(bool)
    softMatchOnUpnEnabled                                = optional(bool)
    synchronizeUpnForManagedUsersEnabled                 = optional(bool)
    unifiedGroupWritebackEnabled                         = optional(bool)
    userForcePasswordChangeOnLogonEnabled                = optional(bool)
    userWritebackEnabled                                 = optional(bool)
  })
  default   = null
  sensitive = true
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onPremisesDirectorySynchronization"
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
