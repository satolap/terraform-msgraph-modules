variable "address" {
  description = "Address of the school."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postOfficeBox   = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
    type            = optional(string)
  })
  default = null
}

variable "administrative_unit" {
  description = "Microsoft Graph administrativeUnit property."
  type        = any
  default     = null
}

variable "classes" {
  description = "Classes taught at the school. Nullable."
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
      addToCalendarAction                     = optional(string)
      addedStudentAction                      = optional(string)
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
      instructions = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationItemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      languageTag            = optional(string)
      moduleUrl              = optional(string)
      notificationChannelUrl = optional(string)
      resources              = optional(any)
      rubric                 = optional(any)
    })))
    classCode = optional(string)
    course = optional(object({
      odata_type   = optional(string, "#microsoft.graph.educationCourse")
      courseNumber = optional(string)
      description  = optional(string)
      displayName  = optional(string)
      externalId   = optional(string)
      subject      = optional(string)
    }))
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    externalId           = optional(string)
    externalName         = optional(string)
    externalSource       = optional(string)
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
      externalSource       = optional(string)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postOfficeBox   = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
        type            = optional(string)
      }))
      middleName     = optional(string)
      mobilePhone    = optional(string)
      officeLocation = optional(string)
      onPremisesInfo = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationOnPremisesInfo")
        immutableId = optional(string)
      }))
      passwordPolicies = optional(string)
      passwordProfile = optional(object({
        odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
        forceChangePasswordNextSignIn        = optional(bool)
        forceChangePasswordNextSignInWithMfa = optional(bool)
        password                             = optional(string)
      }))
      preferredLanguage              = optional(string)
      primaryRole                    = optional(string)
      refreshTokensValidFromDateTime = optional(string)
      relatedContacts                = optional(any)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postOfficeBox   = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
        type            = optional(string)
      }))
      rubrics           = optional(any)
      schools           = optional(any)
      showInAddressList = optional(bool)
      student = optional(object({
        odata_type     = optional(string, "#microsoft.graph.educationStudent")
        birthDate      = optional(string)
        externalId     = optional(string)
        gender         = optional(string)
        grade          = optional(string)
        graduationYear = optional(string)
        studentNumber  = optional(string)
      }))
      surname       = optional(string)
      taughtClasses = optional(any)
      teacher = optional(object({
        odata_type    = optional(string, "#microsoft.graph.educationTeacher")
        externalId    = optional(string)
        teacherNumber = optional(string)
      }))
      usageLocation     = optional(string)
      user              = optional(any)
      userPrincipalName = optional(string)
      userType          = optional(string)
    })))
    modules = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.educationModule")
      description = optional(string)
      displayName = optional(string)
      isPinned    = optional(bool)
      languageTag = optional(string)
      resources   = optional(any)
    })))
    schools = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.educationSchool")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postOfficeBox   = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
        type            = optional(string)
      }))
      administrativeUnit   = optional(any)
      classes              = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalPrincipalId  = optional(string)
      externalSource       = optional(string)
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
      externalSource       = optional(string)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postOfficeBox   = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
        type            = optional(string)
      }))
      middleName     = optional(string)
      mobilePhone    = optional(string)
      officeLocation = optional(string)
      onPremisesInfo = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationOnPremisesInfo")
        immutableId = optional(string)
      }))
      passwordPolicies = optional(string)
      passwordProfile = optional(object({
        odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
        forceChangePasswordNextSignIn        = optional(bool)
        forceChangePasswordNextSignInWithMfa = optional(bool)
        password                             = optional(string)
      }))
      preferredLanguage              = optional(string)
      primaryRole                    = optional(string)
      refreshTokensValidFromDateTime = optional(string)
      relatedContacts                = optional(any)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postOfficeBox   = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
        type            = optional(string)
      }))
      rubrics           = optional(any)
      schools           = optional(any)
      showInAddressList = optional(bool)
      student = optional(object({
        odata_type     = optional(string, "#microsoft.graph.educationStudent")
        birthDate      = optional(string)
        externalId     = optional(string)
        gender         = optional(string)
        grade          = optional(string)
        graduationYear = optional(string)
        studentNumber  = optional(string)
      }))
      surname       = optional(string)
      taughtClasses = optional(any)
      teacher = optional(object({
        odata_type    = optional(string, "#microsoft.graph.educationTeacher")
        externalId    = optional(string)
        teacherNumber = optional(string)
      }))
      usageLocation     = optional(string)
      user              = optional(any)
      userPrincipalName = optional(string)
      userType          = optional(string)
    })))
    term = optional(object({
      odata_type  = optional(string, "#microsoft.graph.educationTerm")
      displayName = optional(string)
      endDate     = optional(string)
      externalId  = optional(string)
      startDate   = optional(string)
    }))
  }))
  default   = null
  sensitive = true
}

variable "created_by" {
  description = "Entity who created the school."
  type        = any
  default     = null
}

variable "description" {
  description = "Organization description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Organization display name."
  type        = string
  default     = null
}

variable "external_id" {
  description = "ID of school in syncing system."
  type        = string
  default     = null
}

variable "external_principal_id" {
  description = "ID of principal in syncing system."
  type        = string
  default     = null
}

variable "external_source" {
  description = "Where this user was created from. The possible values are: sis, lms, or manual."
  type        = string
  default     = null

  validation {
    condition     = var.external_source == null ? true : contains(["sis", "manual", "unknownFutureValue", "lms"], var.external_source)
    error_message = "external_source must be one of the documented enum values."
  }
}

variable "external_source_detail" {
  description = "Microsoft Graph externalSourceDetail property."
  type        = string
  default     = null
}

variable "fax" {
  description = "Microsoft Graph fax property."
  type        = string
  default     = null
}

variable "highest_grade" {
  description = "Highest grade taught."
  type        = string
  default     = null
}

variable "lowest_grade" {
  description = "Lowest grade taught."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationSchool"
  nullable    = false
}

variable "phone" {
  description = "Phone number of school."
  type        = string
  default     = null
}

variable "principal_email" {
  description = "Email address of the principal."
  type        = string
  default     = null
}

variable "principal_name" {
  description = "Name of the principal."
  type        = string
  default     = null
}

variable "school_number" {
  description = "School Number."
  type        = string
  default     = null
}

variable "users" {
  description = "Users in the school. Nullable."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.educationUser")
    accountEnabled = optional(bool)
    assignedLicenses = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.assignedLicense")
      disabledPlans = optional(list(string))
      skuId         = optional(string)
    })))
    assignments = optional(list(object({
      odata_type                              = optional(string, "#microsoft.graph.educationAssignment")
      addToCalendarAction                     = optional(string)
      addedStudentAction                      = optional(string)
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
      instructions = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationItemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      languageTag            = optional(string)
      moduleUrl              = optional(string)
      notificationChannelUrl = optional(string)
      resources              = optional(any)
      rubric                 = optional(any)
    })))
    businessPhones = optional(list(string))
    classes = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationClass")
      assignmentCategories = optional(any)
      assignmentDefaults   = optional(any)
      assignmentSettings   = optional(any)
      assignments          = optional(any)
      classCode            = optional(string)
      course = optional(object({
        odata_type   = optional(string, "#microsoft.graph.educationCourse")
        courseNumber = optional(string)
        description  = optional(string)
        displayName  = optional(string)
        externalId   = optional(string)
        subject      = optional(string)
      }))
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalName         = optional(string)
      externalSource       = optional(string)
      externalSourceDetail = optional(string)
      grade                = optional(string)
      group                = optional(any)
      mailNickname         = optional(string)
      members              = optional(any)
      modules              = optional(any)
      schools              = optional(any)
      teachers             = optional(any)
      term = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationTerm")
        displayName = optional(string)
        endDate     = optional(string)
        externalId  = optional(string)
        startDate   = optional(string)
      }))
    })))
    createdBy            = optional(any)
    department           = optional(string)
    displayName          = optional(string)
    externalSource       = optional(string)
    externalSourceDetail = optional(string)
    givenName            = optional(string)
    mailNickname         = optional(string)
    mailingAddress = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postOfficeBox   = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
      type            = optional(string)
    }))
    middleName     = optional(string)
    mobilePhone    = optional(string)
    officeLocation = optional(string)
    onPremisesInfo = optional(object({
      odata_type  = optional(string, "#microsoft.graph.educationOnPremisesInfo")
      immutableId = optional(string)
    }))
    passwordPolicies = optional(string)
    passwordProfile = optional(object({
      odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
      forceChangePasswordNextSignIn        = optional(bool)
      forceChangePasswordNextSignInWithMfa = optional(bool)
      password                             = optional(string)
    }))
    preferredLanguage              = optional(string)
    primaryRole                    = optional(string)
    refreshTokensValidFromDateTime = optional(string)
    relatedContacts = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.relatedContact")
      accessConsent = optional(bool)
      displayName   = optional(string)
      emailAddress  = optional(string)
      id            = optional(string)
      mobilePhone   = optional(string)
      relationship  = optional(string)
    })))
    residenceAddress = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postOfficeBox   = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
      type            = optional(string)
    }))
    rubrics = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.educationRubric")
      description = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationItemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      displayName = optional(string)
      grading     = optional(any)
      levels      = optional(any)
      qualities   = optional(any)
    })))
    schools = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.educationSchool")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postOfficeBox   = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
        type            = optional(string)
      }))
      administrativeUnit   = optional(any)
      classes              = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalPrincipalId  = optional(string)
      externalSource       = optional(string)
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
    showInAddressList = optional(bool)
    student = optional(object({
      odata_type     = optional(string, "#microsoft.graph.educationStudent")
      birthDate      = optional(string)
      externalId     = optional(string)
      gender         = optional(string)
      grade          = optional(string)
      graduationYear = optional(string)
      studentNumber  = optional(string)
    }))
    surname = optional(string)
    taughtClasses = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.educationClass")
      assignmentCategories = optional(any)
      assignmentDefaults   = optional(any)
      assignmentSettings   = optional(any)
      assignments          = optional(any)
      classCode            = optional(string)
      course = optional(object({
        odata_type   = optional(string, "#microsoft.graph.educationCourse")
        courseNumber = optional(string)
        description  = optional(string)
        displayName  = optional(string)
        externalId   = optional(string)
        subject      = optional(string)
      }))
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      externalId           = optional(string)
      externalName         = optional(string)
      externalSource       = optional(string)
      externalSourceDetail = optional(string)
      grade                = optional(string)
      group                = optional(any)
      mailNickname         = optional(string)
      members              = optional(any)
      modules              = optional(any)
      schools              = optional(any)
      teachers             = optional(any)
      term = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationTerm")
        displayName = optional(string)
        endDate     = optional(string)
        externalId  = optional(string)
        startDate   = optional(string)
      }))
    })))
    teacher = optional(object({
      odata_type    = optional(string, "#microsoft.graph.educationTeacher")
      externalId    = optional(string)
      teacherNumber = optional(string)
    }))
    usageLocation     = optional(string)
    user              = optional(any)
    userPrincipalName = optional(string)
    userType          = optional(string)
  }))
  default   = null
  sensitive = true
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
