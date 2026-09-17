variable "account_enabled" {
  description = "True if the account is enabled; otherwise, false. This property is required when a user is created. Supports $filter."
  type        = bool
  default     = null
}

variable "assigned_licenses" {
  description = "The licenses that are assigned to the user. Not nullable."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.assignedLicense")
    disabledPlans = optional(list(string))
    skuId         = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "Assignments belonging to the user."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.educationAssignment")
    addToCalendarAction                     = optional(any)
    addedStudentAction                      = optional(any)
    allowLateSubmissions                    = optional(bool)
    allowStudentsToAddResourcesToSubmission = optional(bool)
    assignTo                                = optional(any)
    classId                                 = optional(string)
    closeDateTime                           = optional(string)
    displayName                             = optional(string)
    dueDateTime                             = optional(string)
    grading                                 = optional(any)
    gradingCategory                         = optional(any)
    gradingScheme                           = optional(any)
    instructions                            = optional(any)
    languageTag                             = optional(string)
    moduleUrl                               = optional(string)
    notificationChannelUrl                  = optional(string)
    resources = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.educationAssignmentResource")
      dependentResources       = optional(any)
      distributeForStudentWork = optional(bool)
      resource                 = optional(any)
    })))
    rubric = optional(any)
  }))
  default = null
}

variable "business_phones" {
  description = "The telephone numbers for the user. Note: Although this is a string collection, only one number can be set for this property."
  type        = list(string)
  default     = null
}

variable "classes" {
  description = "Classes to which the user belongs. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.educationClass")
    assignmentCategories = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.educationCategory")
      displayName = optional(string)
    })))
    assignmentDefaults = optional(any)
    assignmentSettings = optional(any)
    assignments = optional(list(object({
      odata_type                              = optional(string, "#microsoft.graph.educationAssignment")
      addToCalendarAction                     = optional(any)
      addedStudentAction                      = optional(any)
      allowLateSubmissions                    = optional(bool)
      allowStudentsToAddResourcesToSubmission = optional(bool)
      assignTo                                = optional(any)
      classId                                 = optional(string)
      closeDateTime                           = optional(string)
      displayName                             = optional(string)
      dueDateTime                             = optional(string)
      grading                                 = optional(any)
      gradingCategory                         = optional(any)
      gradingScheme                           = optional(any)
      instructions                            = optional(any)
      languageTag                             = optional(string)
      moduleUrl                               = optional(string)
      notificationChannelUrl                  = optional(string)
      resources                               = optional(any)
      rubric                                  = optional(any)
    })))
    classCode            = optional(string)
    course               = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    externalId           = optional(string)
    externalName         = optional(string)
    externalSource       = optional(any)
    externalSourceDetail = optional(string)
    grade                = optional(string)
    group                = optional(any)
    mailNickname         = optional(string)
    members = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationUser")
      accountEnabled       = optional(bool)
      assignedLicenses     = optional(any)
      assignments          = optional(any)
      businessPhones       = optional(list(string))
      classes              = optional(any)
      createdBy            = optional(any)
      department           = optional(string)
      displayName          = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress       = optional(any)
      middleName           = optional(string)
      mobilePhone          = optional(string)
      officeLocation       = optional(string)
      onPremisesInfo       = optional(any)
      passwordPolicies     = optional(string)
      passwordProfile      = optional(any)
      preferredLanguage    = optional(string)
      primaryRole          = optional(string)
      residenceAddress     = optional(any)
      rubrics              = optional(any)
      schools              = optional(any)
      showInAddressList    = optional(bool)
      student              = optional(any)
      surname              = optional(string)
      taughtClasses        = optional(any)
      teacher              = optional(any)
      usageLocation        = optional(string)
      user                 = optional(any)
      userPrincipalName    = optional(string)
      userType             = optional(string)
    })))
    modules = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.educationModule")
      description = optional(string)
      displayName = optional(string)
      isPinned    = optional(bool)
      resources   = optional(any)
    })))
    schools = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationSchool")
      address              = optional(any)
      administrativeUnit   = optional(any)
      classes              = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalPrincipalId  = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      fax                  = optional(string)
      highestGrade         = optional(string)
      lowestGrade          = optional(string)
      phone                = optional(string)
      principalEmail       = optional(string)
      principalName        = optional(string)
      schoolNumber         = optional(string)
      users                = optional(any)
    })))
    teachers = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationUser")
      accountEnabled       = optional(bool)
      assignedLicenses     = optional(any)
      assignments          = optional(any)
      businessPhones       = optional(list(string))
      classes              = optional(any)
      createdBy            = optional(any)
      department           = optional(string)
      displayName          = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress       = optional(any)
      middleName           = optional(string)
      mobilePhone          = optional(string)
      officeLocation       = optional(string)
      onPremisesInfo       = optional(any)
      passwordPolicies     = optional(string)
      passwordProfile      = optional(any)
      preferredLanguage    = optional(string)
      primaryRole          = optional(string)
      residenceAddress     = optional(any)
      rubrics              = optional(any)
      schools              = optional(any)
      showInAddressList    = optional(bool)
      student              = optional(any)
      surname              = optional(string)
      taughtClasses        = optional(any)
      teacher              = optional(any)
      usageLocation        = optional(string)
      user                 = optional(any)
      userPrincipalName    = optional(string)
      userType             = optional(string)
    })))
    term = optional(any)
  }))
  default   = null
  sensitive = true
}

variable "created_by" {
  description = "The entity who created the user."
  type        = any
  default     = null
}

variable "department" {
  description = "The name for the department in which the user works. Supports $filter."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name displayed in the address book for the user. This is usually the combination of the user's first name, middle initial, and last name. This property is required when a user is created and it cannot be cleared during updates. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "external_source" {
  description = "Where this user was created from. The possible values are: sis, manual."
  type        = any
  default     = null

  validation {
    condition     = var.external_source == null ? true : contains(["sis", "manual", "unknownFutureValue"], var.external_source)
    error_message = "external_source must be one of the documented enum values."
  }
}

variable "external_source_detail" {
  description = "The name of the external source this resource was generated from."
  type        = string
  default     = null
}

variable "given_name" {
  description = "The given name (first name) of the user. Supports $filter."
  type        = string
  default     = null
}

variable "mail_nickname" {
  description = "The mail alias for the user. This property must be specified when a user is created. Supports $filter."
  type        = string
  default     = null
}

variable "mailing_address" {
  description = "The mail address of the user."
  type        = any
  default     = null
}

variable "middle_name" {
  description = "The middle name of the user."
  type        = string
  default     = null
}

variable "mobile_phone" {
  description = "The primary cellular telephone number for the user."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationUser"
  nullable    = false
}

variable "office_location" {
  description = "The office location for the user."
  type        = string
  default     = null
}

variable "on_premises_info" {
  description = "Additional information used to associate the Microsoft Entra user with its Active Directory counterpart."
  type        = any
  default     = null
}

variable "password_policies" {
  description = "Specifies password policies for the user. This value is an enumeration with one possible value being DisableStrongPassword, which allows weaker passwords than the default policy to be specified. DisablePasswordExpiration can also be specified. The two can be specified together; for example: DisablePasswordExpiration, DisableStrongPassword."
  type        = string
  default     = null
  sensitive   = true
}

variable "password_profile" {
  description = "Specifies the password profile for the user. The profile contains the user's password. This property is required when a user is created. The password in the profile must satisfy minimum requirements as specified by the passwordPolicies property. By default, a strong password is required."
  type        = any
  default     = null
  sensitive   = true
}

variable "preferred_language" {
  description = "The preferred language for the user that should follow the ISO 639-1 code, for example, en-US."
  type        = string
  default     = null
}

variable "primary_role" {
  description = "Microsoft Graph primaryRole property."
  type        = string
  default     = null

  validation {
    condition     = var.primary_role == null ? true : contains(["student", "teacher", "none", "unknownFutureValue"], var.primary_role)
    error_message = "primary_role must be one of the documented enum values."
  }
}

variable "residence_address" {
  description = "The address where the user lives."
  type        = any
  default     = null
}

variable "rubrics" {
  description = "When set, the grading rubric attached to the assignment."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.educationRubric")
    description = optional(any)
    displayName = optional(string)
    grading     = optional(any)
    levels = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.rubricLevel")
      description = optional(any)
      displayName = optional(string)
      grading     = optional(any)
      levelId     = optional(string)
    })))
    qualities = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.rubricQuality")
      criteria    = optional(any)
      description = optional(any)
      displayName = optional(string)
      qualityId   = optional(string)
      weight      = optional(any)
    })))
  }))
  default = null
}

variable "schools" {
  description = "Schools to which the user belongs. Nullable."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.educationSchool")
    address            = optional(any)
    administrativeUnit = optional(any)
    classes = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationClass")
      assignmentCategories = optional(any)
      assignmentDefaults   = optional(any)
      assignmentSettings   = optional(any)
      assignments          = optional(any)
      classCode            = optional(string)
      course               = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalName         = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      grade                = optional(string)
      group                = optional(any)
      mailNickname         = optional(string)
      members              = optional(any)
      modules              = optional(any)
      schools              = optional(any)
      teachers             = optional(any)
      term                 = optional(any)
    })))
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    externalId           = optional(string)
    externalPrincipalId  = optional(string)
    externalSource       = optional(any)
    externalSourceDetail = optional(string)
    fax                  = optional(string)
    highestGrade         = optional(string)
    lowestGrade          = optional(string)
    phone                = optional(string)
    principalEmail       = optional(string)
    principalName        = optional(string)
    schoolNumber         = optional(string)
    users = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationUser")
      accountEnabled       = optional(bool)
      assignedLicenses     = optional(any)
      assignments          = optional(any)
      businessPhones       = optional(list(string))
      classes              = optional(any)
      createdBy            = optional(any)
      department           = optional(string)
      displayName          = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress       = optional(any)
      middleName           = optional(string)
      mobilePhone          = optional(string)
      officeLocation       = optional(string)
      onPremisesInfo       = optional(any)
      passwordPolicies     = optional(string)
      passwordProfile      = optional(any)
      preferredLanguage    = optional(string)
      primaryRole          = optional(string)
      residenceAddress     = optional(any)
      rubrics              = optional(any)
      schools              = optional(any)
      showInAddressList    = optional(bool)
      student              = optional(any)
      surname              = optional(string)
      taughtClasses        = optional(any)
      teacher              = optional(any)
      usageLocation        = optional(string)
      user                 = optional(any)
      userPrincipalName    = optional(string)
      userType             = optional(string)
    })))
  }))
  default   = null
  sensitive = true
}

variable "show_in_address_list" {
  description = "True if the Outlook Global Address List should contain this user; otherwise, false. If not set, this will be treated as true. For users invited through the invitation manager, this property will be set to false."
  type        = bool
  default     = null
}

variable "student" {
  description = "If the primary role is student, this block will contain student specific data."
  type        = any
  default     = null
}

variable "surname" {
  description = "The user's surname (family name or last name). Supports $filter."
  type        = string
  default     = null
}

variable "taught_classes" {
  description = "Classes for which the user is a teacher."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.educationClass")
    assignmentCategories = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.educationCategory")
      displayName = optional(string)
    })))
    assignmentDefaults = optional(any)
    assignmentSettings = optional(any)
    assignments = optional(list(object({
      odata_type                              = optional(string, "#microsoft.graph.educationAssignment")
      addToCalendarAction                     = optional(any)
      addedStudentAction                      = optional(any)
      allowLateSubmissions                    = optional(bool)
      allowStudentsToAddResourcesToSubmission = optional(bool)
      assignTo                                = optional(any)
      classId                                 = optional(string)
      closeDateTime                           = optional(string)
      displayName                             = optional(string)
      dueDateTime                             = optional(string)
      grading                                 = optional(any)
      gradingCategory                         = optional(any)
      gradingScheme                           = optional(any)
      instructions                            = optional(any)
      languageTag                             = optional(string)
      moduleUrl                               = optional(string)
      notificationChannelUrl                  = optional(string)
      resources                               = optional(any)
      rubric                                  = optional(any)
    })))
    classCode            = optional(string)
    course               = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    externalId           = optional(string)
    externalName         = optional(string)
    externalSource       = optional(any)
    externalSourceDetail = optional(string)
    grade                = optional(string)
    group                = optional(any)
    mailNickname         = optional(string)
    members = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationUser")
      accountEnabled       = optional(bool)
      assignedLicenses     = optional(any)
      assignments          = optional(any)
      businessPhones       = optional(list(string))
      classes              = optional(any)
      createdBy            = optional(any)
      department           = optional(string)
      displayName          = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress       = optional(any)
      middleName           = optional(string)
      mobilePhone          = optional(string)
      officeLocation       = optional(string)
      onPremisesInfo       = optional(any)
      passwordPolicies     = optional(string)
      passwordProfile      = optional(any)
      preferredLanguage    = optional(string)
      primaryRole          = optional(string)
      residenceAddress     = optional(any)
      rubrics              = optional(any)
      schools              = optional(any)
      showInAddressList    = optional(bool)
      student              = optional(any)
      surname              = optional(string)
      taughtClasses        = optional(any)
      teacher              = optional(any)
      usageLocation        = optional(string)
      user                 = optional(any)
      userPrincipalName    = optional(string)
      userType             = optional(string)
    })))
    modules = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.educationModule")
      description = optional(string)
      displayName = optional(string)
      isPinned    = optional(bool)
      resources   = optional(any)
    })))
    schools = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationSchool")
      address              = optional(any)
      administrativeUnit   = optional(any)
      classes              = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalPrincipalId  = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      fax                  = optional(string)
      highestGrade         = optional(string)
      lowestGrade          = optional(string)
      phone                = optional(string)
      principalEmail       = optional(string)
      principalName        = optional(string)
      schoolNumber         = optional(string)
      users                = optional(any)
    })))
    teachers = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationUser")
      accountEnabled       = optional(bool)
      assignedLicenses     = optional(any)
      assignments          = optional(any)
      businessPhones       = optional(list(string))
      classes              = optional(any)
      createdBy            = optional(any)
      department           = optional(string)
      displayName          = optional(string)
      externalSource       = optional(any)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress       = optional(any)
      middleName           = optional(string)
      mobilePhone          = optional(string)
      officeLocation       = optional(string)
      onPremisesInfo       = optional(any)
      passwordPolicies     = optional(string)
      passwordProfile      = optional(any)
      preferredLanguage    = optional(string)
      primaryRole          = optional(string)
      residenceAddress     = optional(any)
      rubrics              = optional(any)
      schools              = optional(any)
      showInAddressList    = optional(bool)
      student              = optional(any)
      surname              = optional(string)
      taughtClasses        = optional(any)
      teacher              = optional(any)
      usageLocation        = optional(string)
      user                 = optional(any)
      userPrincipalName    = optional(string)
      userType             = optional(string)
    })))
    term = optional(any)
  }))
  default   = null
  sensitive = true
}

variable "teacher" {
  description = "If the primary role is teacher, this block will contain teacher specific data."
  type        = any
  default     = null
}

variable "usage_location" {
  description = "A two-letter country code (ISO standard 3166). Required for users who will be assigned licenses due to a legal requirement to check for availability of services in countries or regions. Examples include: US, JP, and GB. Not nullable. Supports $filter."
  type        = string
  default     = null
}

variable "user" {
  description = "The directory user that corresponds to this user."
  type        = any
  default     = null
}

variable "user_principal_name" {
  description = "The user principal name (UPN) of the user. The UPN is an internet-style login name for the user based on the internet standard RFC 822. By convention, this should map to the user's email name. The general format is alias@domain, where domain must be present in the tenant's collection of verified domains. This property is required when a user is created. The verified domains for the tenant can be accessed from the verifiedDomains property of the organization. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "user_type" {
  description = "A string value that can be used to classify user types in your directory, such as Member and Guest. Supports $filter."
  type        = string
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignedPlans", "id", "mail", "provisionedPlans", "refreshTokensValidFromDateTime", "relatedContacts"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
