variable "deviceCount" {
  description = "The number of devices that have installed this application"
  type        = number
  default     = null
}

variable "managedDevices" {
  description = "The devices that have the discovered application installed"
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.managedDevice")
    deviceCategory = optional(any)
    deviceCompliancePolicyStates = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.deviceCompliancePolicyState")
      displayName   = optional(string)
      platformType  = optional(string)
      settingCount  = optional(number)
      settingStates = optional(any)
      state         = optional(string)
      version       = optional(number)
    })))
    deviceConfigurationStates = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.deviceConfigurationState")
      displayName   = optional(string)
      platformType  = optional(string)
      settingCount  = optional(number)
      settingStates = optional(any)
      state         = optional(string)
      version       = optional(number)
    })))
    logCollectionRequests = optional(list(object({
      odata_type                   = optional(string, "#microsoft.graph.deviceLogCollectionResponse")
      enrolledByUser               = optional(string)
      expirationDateTimeUTC        = optional(string)
      initiatedByUserPrincipalName = optional(string)
      managedDeviceId              = optional(string)
      receivedDateTimeUTC          = optional(string)
      requestedDateTimeUTC         = optional(string)
      sizeInKB                     = optional(any)
      status                       = optional(string)
    })))
    managedDeviceName      = optional(string)
    managedDeviceOwnerType = optional(string)
    notes                  = optional(string)
    users = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.user")
      aboutMe            = optional(string)
      accountEnabled     = optional(bool)
      ageGroup           = optional(string)
      appRoleAssignments = optional(any)
      assignedLicenses   = optional(any)
      authentication     = optional(any)
      authorizationInfo = optional(object({
        odata_type         = optional(string, "#microsoft.graph.authorizationInfo")
        certificateUserIds = optional(any)
      }))
      birthday                              = optional(string)
      chats                                 = optional(any)
      city                                  = optional(string)
      cloudClipboard                        = optional(any)
      companyName                           = optional(string)
      consentProvidedForMinor               = optional(string)
      country                               = optional(string)
      customSecurityAttributes              = optional(any)
      deletedDateTime                       = optional(string)
      department                            = optional(string)
      deviceEnrollmentLimit                 = optional(number)
      deviceManagementTroubleshootingEvents = optional(any)
      displayName                           = optional(string)
      employeeExperience                    = optional(any)
      employeeHireDate                      = optional(string)
      employeeId                            = optional(string)
      employeeLeaveDateTime                 = optional(string)
      employeeOrgData = optional(object({
        odata_type = optional(string, "#microsoft.graph.employeeOrgData")
        costCenter = optional(string)
        division   = optional(string)
      }))
      employeeType                    = optional(string)
      externalUserState               = optional(string)
      externalUserStateChangeDateTime = optional(string)
      faxNumber                       = optional(string)
      followedSites                   = optional(any)
      givenName                       = optional(string)
      hireDate                        = optional(string)
      identities                      = optional(any)
      identityParentId                = optional(string)
      inferenceClassification         = optional(any)
      interests                       = optional(list(string))
      isResourceAccount               = optional(bool)
      jobTitle                        = optional(string)
      joinedTeams                     = optional(any)
      lastPasswordChangeDateTime      = optional(string)
      mail                            = optional(string)
      mailNickname                    = optional(string)
      mailboxSettings = optional(object({
        odata_type                            = optional(string, "#microsoft.graph.mailboxSettings")
        archiveFolder                         = optional(string)
        automaticRepliesSetting               = optional(any)
        dateFormat                            = optional(string)
        delegateMeetingMessageDeliveryOptions = optional(string)
        language                              = optional(any)
        timeFormat                            = optional(string)
        timeZone                              = optional(string)
        workingHours                          = optional(any)
      }))
      managedAppRegistrations      = optional(any)
      managedDevices               = optional(any)
      mySite                       = optional(string)
      oauth2PermissionGrants       = optional(any)
      officeLocation               = optional(string)
      onPremisesImmutableId        = optional(string)
      onPremisesProvisioningErrors = optional(any)
      onPremisesSyncBehavior       = optional(any)
      onenote                      = optional(any)
      onlineMeetings               = optional(any)
      otherMails                   = optional(list(string))
      outlook                      = optional(any)
      passwordPolicies             = optional(string)
      passwordProfile = optional(object({
        odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
        forceChangePasswordNextSignIn        = optional(bool)
        forceChangePasswordNextSignInWithMfa = optional(bool)
        password                             = optional(string)
      }))
      pastProjects          = optional(list(string))
      permissionGrants      = optional(any)
      postalCode            = optional(string)
      preferredDataLocation = optional(string)
      preferredLanguage     = optional(string)
      preferredName         = optional(string)
      presence              = optional(any)
      print = optional(object({
        odata_type          = optional(string, "#microsoft.graph.userPrint")
        recentPrinterShares = optional(any)
      }))
      responsibilities          = optional(list(string))
      schools                   = optional(list(string))
      scopedRoleMemberOf        = optional(any)
      serviceProvisioningErrors = optional(any)
      settings                  = optional(any)
      showInAddressList         = optional(bool)
      skills                    = optional(list(string))
      sponsors                  = optional(any)
      state                     = optional(string)
      streetAddress             = optional(string)
      surname                   = optional(string)
      todo                      = optional(any)
      transitiveMemberOf        = optional(any)
      usageLocation             = optional(string)
      userPrincipalName         = optional(string)
      userType                  = optional(string)
    })))
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.managedDevices == null ? true : alltrue([alltrue([for input0 in var.managedDevices : (input0 == null ? true : alltrue([(input0["deviceCompliancePolicyStates"] == null ? true : alltrue([alltrue([for input2 in input0["deviceCompliancePolicyStates"] : (input2 == null ? true : alltrue([(input2["platformType"] == null ? true : alltrue([(input2["platformType"] == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "all"], input2["platformType"]))])), (input2["state"] == null ? true : alltrue([(input2["state"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input2["state"]))]))]))])])), (input0["deviceConfigurationStates"] == null ? true : alltrue([alltrue([for input2 in input0["deviceConfigurationStates"] : (input2 == null ? true : alltrue([(input2["platformType"] == null ? true : alltrue([(input2["platformType"] == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "all"], input2["platformType"]))])), (input2["state"] == null ? true : alltrue([(input2["state"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input2["state"]))]))]))])])), (input0["logCollectionRequests"] == null ? true : alltrue([alltrue([for input2 in input0["logCollectionRequests"] : (input2 == null ? true : alltrue([(input2["status"] == null ? true : alltrue([(input2["status"] == null ? true : contains(["pending", "completed", "failed"], input2["status"]))]))]))])])), (input0["managedDeviceOwnerType"] == null ? true : alltrue([(input0["managedDeviceOwnerType"] == null ? true : contains(["unknown", "company", "personal"], input0["managedDeviceOwnerType"]))])), (input0["users"] == null ? true : alltrue([alltrue([for input2 in input0["users"] : (input2 == null ? true : alltrue([(input2["mailboxSettings"] == null ? true : alltrue([(input2["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : alltrue([(input2["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"] == null ? true : contains(["sendToDelegateAndInformationToPrincipal", "sendToDelegateAndPrincipal", "sendToDelegateOnly"], input2["mailboxSettings"]["delegateMeetingMessageDeliveryOptions"]))]))]))]))])]))]))])]))
    error_message = "managedDevices: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.detectedApp"
  nullable    = false
}

variable "platform" {
  description = "Indicates the operating system / platform of the discovered application.  Some possible values are Windows, iOS, macOS. The default value is unknown (0)."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["unknown", "windows", "windowsMobile", "windowsHolographic", "ios", "macOS", "chromeOS", "androidOSP", "androidDeviceAdministrator", "androidWorkProfile", "androidDedicatedAndFullyManaged"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "publisher" {
  description = "Indicates the publisher of the discovered application. For example: 'Microsoft'.  The default value is an empty string."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id", "sizeInByte", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
