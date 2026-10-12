variable "assignment_categories" {
  description = "All categories associated with this class. Nullable."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.educationCategory")
    displayName = optional(string)
  }))
  default = null
}

variable "assignment_defaults" {
  description = "Specifies class-level defaults respected by new assignments created in the class."
  type        = any
  default     = null
}

variable "assignment_settings" {
  description = "Specifies class-level assignments settings."
  type        = any
  default     = null
}

variable "assignments" {
  description = "All assignments associated with this class. Nullable."
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
}

variable "class_code" {
  description = "Class code used by the school to identify the class."
  type        = string
  default     = null
}

variable "course" {
  description = "Microsoft Graph course property."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.educationCourse")
    courseNumber = optional(string)
    description  = optional(string)
    displayName  = optional(string)
    externalId   = optional(string)
    subject      = optional(string)
  })
  default = null
}

variable "created_by" {
  description = "Entity who created the class"
  type        = any
  default     = null
}

variable "description" {
  description = "Description of the class."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the class."
  type        = string
  default     = null
}

variable "external_id" {
  description = "ID of the class from the syncing system."
  type        = string
  default     = null
}

variable "external_name" {
  description = "Name of the class in the syncing system."
  type        = string
  default     = null
}

variable "external_source" {
  description = "How this class was created. The possible values are: sis, manual."
  type        = string
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

variable "grade" {
  description = "Grade level of the class."
  type        = string
  default     = null
}

variable "group" {
  description = "The underlying Microsoft 365 group object."
  type        = any
  default     = null
}

variable "mail_nickname" {
  description = "Mail name for sending email to all members, if this is enabled."
  type        = string
  default     = null
}

variable "members" {
  description = "All users in the class. Nullable."
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

variable "modules" {
  description = "All modules in the class. Nullable."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.educationModule")
    description = optional(string)
    displayName = optional(string)
    isPinned    = optional(bool)
    resources = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.educationModuleResource")
      resource   = optional(any)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationClass"
  nullable    = false
}

variable "schools" {
  description = "All schools that this class is associated with. Nullable."
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
}

variable "teachers" {
  description = "All teachers in the class. Nullable."
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

variable "term" {
  description = "Term for this class."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.educationTerm")
    displayName = optional(string)
    endDate     = optional(string)
    externalId  = optional(string)
    startDate   = optional(string)
  })
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
