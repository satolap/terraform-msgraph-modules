variable "accountEnabled" {
  description = "True if the account is enabled; otherwise, false. This property is required when a user is created. Supports $filter."
  type        = bool
  default     = null
}

variable "assignedLicenses" {
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
    resources = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.educationAssignmentResource")
      dependentResources       = optional(any)
      distributeForStudentWork = optional(bool)
      resource                 = optional(any)
    })))
    rubric = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["addToCalendarAction"] == null ? true : alltrue([(input0["addToCalendarAction"] == null ? true : contains(["none", "studentsAndPublisher", "studentsAndTeamOwners"], input0["addToCalendarAction"]))])), (input0["addedStudentAction"] == null ? true : alltrue([(input0["addedStudentAction"] == null ? true : contains(["none", "assignIfOpen"], input0["addedStudentAction"]))])), (input0["instructions"] == null ? true : alltrue([(input0["instructions"]["contentType"] == null ? true : alltrue([(input0["instructions"]["contentType"] == null ? true : contains(["text", "html"], input0["instructions"]["contentType"]))]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "businessPhones" {
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
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      preferredLanguage = optional(string)
      primaryRole       = optional(string)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      resources   = optional(any)
    })))
    schools = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.educationSchool")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      preferredLanguage = optional(string)
      primaryRole       = optional(string)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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

  validation {
    condition     = (var.classes == null ? true : alltrue([alltrue([for input0 in var.classes : (input0 == null ? true : alltrue([(input0["assignments"] == null ? true : alltrue([alltrue([for input2 in input0["assignments"] : (input2 == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : contains(["none", "studentsAndPublisher", "studentsAndTeamOwners"], input2["addToCalendarAction"]))])), (input2["addedStudentAction"] == null ? true : alltrue([(input2["addedStudentAction"] == null ? true : contains(["none", "assignIfOpen"], input2["addedStudentAction"]))])), (input2["instructions"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : contains(["text", "html"], input2["instructions"]["contentType"]))]))]))]))])])), (input0["externalSource"] == null ? true : alltrue([(input0["externalSource"] == null ? true : contains(["sis", "manual"], input0["externalSource"]))])), (input0["members"] == null ? true : alltrue([alltrue([for input2 in input0["members"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])])), (input0["schools"] == null ? true : alltrue([alltrue([for input2 in input0["schools"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])])), (input0["teachers"] == null ? true : alltrue([alltrue([for input2 in input0["teachers"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])]))]))])]))
    error_message = "classes: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "createdBy" {
  description = "The entity who created the user."
  type        = any
  default     = null
}

variable "department" {
  description = "The name for the department in which the user works. Supports $filter."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The name displayed in the address book for the user. This is usually the combination of the user's first name, middle initial, and last name. This property is required when a user is created and it cannot be cleared during updates. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "externalSource" {
  description = "Where this user was created from. The possible values are: sis, manual."
  type        = string
  default     = null

  validation {
    condition     = var.externalSource == null ? true : contains(["sis", "manual"], var.externalSource)
    error_message = "externalSource must be one of the documented enum values."
  }
}

variable "externalSourceDetail" {
  description = "The name of the external source this resource was generated from."
  type        = string
  default     = null
}

variable "givenName" {
  description = "The given name (first name) of the user. Supports $filter."
  type        = string
  default     = null
}

variable "mailNickname" {
  description = "The mail alias for the user. This property must be specified when a user is created. Supports $filter."
  type        = string
  default     = null
}

variable "mailingAddress" {
  description = "The mail address of the user."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
  })
  default = null
}

variable "middleName" {
  description = "The middle name of the user."
  type        = string
  default     = null
}

variable "mobilePhone" {
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

variable "officeLocation" {
  description = "The office location for the user."
  type        = string
  default     = null
}

variable "onPremisesInfo" {
  description = "Additional information used to associate the Microsoft Entra user with its Active Directory counterpart."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.educationOnPremisesInfo")
    immutableId = optional(string)
  })
  default = null
}

variable "passwordPolicies" {
  description = "Specifies password policies for the user. This value is an enumeration with one possible value being DisableStrongPassword, which allows weaker passwords than the default policy to be specified. DisablePasswordExpiration can also be specified. The two can be specified together; for example: DisablePasswordExpiration, DisableStrongPassword."
  type        = string
  default     = null
  sensitive   = true
}

variable "passwordProfile" {
  description = "Specifies the password profile for the user. The profile contains the user's password. This property is required when a user is created. The password in the profile must satisfy minimum requirements as specified by the passwordPolicies property. By default, a strong password is required."
  type = object({
    odata_type                           = optional(string, "#microsoft.graph.passwordProfile")
    forceChangePasswordNextSignIn        = optional(bool)
    forceChangePasswordNextSignInWithMfa = optional(bool)
    password                             = optional(string)
  })
  default   = null
  sensitive = true
}

variable "preferredLanguage" {
  description = "The preferred language for the user that should follow the ISO 639-1 code, for example, en-US."
  type        = string
  default     = null
}

variable "primaryRole" {
  description = "Microsoft Graph primaryRole property."
  type        = string
  default     = null

  validation {
    condition     = var.primaryRole == null ? true : contains(["student", "teacher", "none"], var.primaryRole)
    error_message = "primaryRole must be one of the documented enum values."
  }
}

variable "residenceAddress" {
  description = "The address where the user lives."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
  })
  default = null
}

variable "rubrics" {
  description = "When set, the grading rubric attached to the assignment."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.educationRubric")
    description = optional(object({
      odata_type  = optional(string, "#microsoft.graph.educationItemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    displayName = optional(string)
    grading     = optional(any)
    levels = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.rubricLevel")
      description = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationItemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      displayName = optional(string)
      grading     = optional(any)
      levelId     = optional(string)
    })))
    qualities = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.rubricQuality")
      criteria   = optional(any)
      description = optional(object({
        odata_type  = optional(string, "#microsoft.graph.educationItemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      displayName = optional(string)
      qualityId   = optional(string)
      weight      = optional(any)
    })))
  }))
  default = null

  validation {
    condition     = (var.rubrics == null ? true : alltrue([alltrue([for input0 in var.rubrics : (input0 == null ? true : alltrue([(input0["description"] == null ? true : alltrue([(input0["description"]["contentType"] == null ? true : alltrue([(input0["description"]["contentType"] == null ? true : contains(["text", "html"], input0["description"]["contentType"]))]))])), (input0["levels"] == null ? true : alltrue([alltrue([for input2 in input0["levels"] : (input2 == null ? true : alltrue([(input2["description"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : contains(["text", "html"], input2["description"]["contentType"]))]))]))]))])])), (input0["qualities"] == null ? true : alltrue([alltrue([for input2 in input0["qualities"] : (input2 == null ? true : alltrue([(input2["description"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : contains(["text", "html"], input2["description"]["contentType"]))]))]))]))])]))]))])]))
    error_message = "rubrics: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "schools" {
  description = "Schools to which the user belongs. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.educationSchool")
    address = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
    }))
    administrativeUnit = optional(any)
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
      externalSource       = optional(string)
      externalSourceDetail = optional(string)
      givenName            = optional(string)
      mailNickname         = optional(string)
      mailingAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      preferredLanguage = optional(string)
      primaryRole       = optional(string)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.schools == null ? true : alltrue([alltrue([for input0 in var.schools : (input0 == null ? true : alltrue([(input0["classes"] == null ? true : alltrue([alltrue([for input2 in input0["classes"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])])), (input0["externalSource"] == null ? true : alltrue([(input0["externalSource"] == null ? true : contains(["sis", "manual"], input0["externalSource"]))])), (input0["users"] == null ? true : alltrue([alltrue([for input2 in input0["users"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])]))]))])]))
    error_message = "schools: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "showInAddressList" {
  description = "True if the Outlook Global Address List should contain this user; otherwise, false. If not set, this will be treated as true. For users invited through the invitation manager, this property will be set to false."
  type        = bool
  default     = null
}

variable "student" {
  description = "If the primary role is student, this block will contain student specific data."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.educationStudent")
    birthDate      = optional(string)
    externalId     = optional(string)
    gender         = optional(string)
    grade          = optional(string)
    graduationYear = optional(string)
    studentNumber  = optional(string)
  })
  default = null

  validation {
    condition     = (var.student == null ? true : alltrue([(var.student["gender"] == null ? true : alltrue([(var.student["gender"] == null ? true : contains(["female", "male", "other"], var.student["gender"]))]))]))
    error_message = "student: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "surname" {
  description = "The user's surname (family name or last name). Supports $filter."
  type        = string
  default     = null
}

variable "taughtClasses" {
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
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      preferredLanguage = optional(string)
      primaryRole       = optional(string)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      resources   = optional(any)
    })))
    schools = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.educationSchool")
      address = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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
      preferredLanguage = optional(string)
      primaryRole       = optional(string)
      residenceAddress = optional(object({
        odata_type      = optional(string, "#microsoft.graph.physicalAddress")
        city            = optional(string)
        countryOrRegion = optional(string)
        postalCode      = optional(string)
        state           = optional(string)
        street          = optional(string)
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

  validation {
    condition     = (var.taughtClasses == null ? true : alltrue([alltrue([for input0 in var.taughtClasses : (input0 == null ? true : alltrue([(input0["assignments"] == null ? true : alltrue([alltrue([for input2 in input0["assignments"] : (input2 == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : contains(["none", "studentsAndPublisher", "studentsAndTeamOwners"], input2["addToCalendarAction"]))])), (input2["addedStudentAction"] == null ? true : alltrue([(input2["addedStudentAction"] == null ? true : contains(["none", "assignIfOpen"], input2["addedStudentAction"]))])), (input2["instructions"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : contains(["text", "html"], input2["instructions"]["contentType"]))]))]))]))])])), (input0["externalSource"] == null ? true : alltrue([(input0["externalSource"] == null ? true : contains(["sis", "manual"], input0["externalSource"]))])), (input0["members"] == null ? true : alltrue([alltrue([for input2 in input0["members"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])])), (input0["schools"] == null ? true : alltrue([alltrue([for input2 in input0["schools"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])])), (input0["teachers"] == null ? true : alltrue([alltrue([for input2 in input0["teachers"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])]))]))])]))
    error_message = "taughtClasses: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "teacher" {
  description = "If the primary role is teacher, this block will contain teacher specific data."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.educationTeacher")
    externalId    = optional(string)
    teacherNumber = optional(string)
  })
  default = null
}

variable "usageLocation" {
  description = "A two-letter country code (ISO standard 3166). Required for users who will be assigned licenses due to a legal requirement to check for availability of services in countries or regions. Examples include: US, JP, and GB. Not nullable. Supports $filter."
  type        = string
  default     = null
}

variable "user" {
  description = "The directory user that corresponds to this user."
  type        = any
  default     = null
}

variable "userPrincipalName" {
  description = "The user principal name (UPN) of the user. The UPN is an internet-style login name for the user based on the internet standard RFC 822. By convention, this should map to the user's email name. The general format is alias@domain, where domain must be present in the tenant's collection of verified domains. This property is required when a user is created. The verified domains for the tenant can be accessed from the verifiedDomains property of the organization. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "userType" {
  description = "A string value that can be used to classify user types in your directory, such as Member and Guest. Supports $filter."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignedPlans", "id", "mail", "provisionedPlans", "refreshTokensValidFromDateTime", "relatedContacts"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
