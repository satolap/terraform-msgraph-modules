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

  validation {
    condition     = (var.address == null ? true : alltrue([(var.address["type"] == null ? true : alltrue([(var.address["type"] == null ? true : contains(["unknown", "home", "business", "other"], var.address["type"]))]))]))
    error_message = "address: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.classes == null ? true : alltrue([alltrue([for input0 in var.classes : (input0 == null ? true : alltrue([(input0["assignments"] == null ? true : alltrue([alltrue([for input2 in input0["assignments"] : (input2 == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : contains(["none", "studentsAndPublisher", "studentsAndTeamOwners"], input2["addToCalendarAction"]))])), (input2["addedStudentAction"] == null ? true : alltrue([(input2["addedStudentAction"] == null ? true : contains(["none", "assignIfOpen"], input2["addedStudentAction"]))])), (input2["instructions"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : contains(["text", "html"], input2["instructions"]["contentType"]))]))]))]))])])), (input0["externalSource"] == null ? true : alltrue([(input0["externalSource"] == null ? true : contains(["sis", "manual"], input0["externalSource"]))])), (input0["members"] == null ? true : alltrue([alltrue([for input2 in input0["members"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["mailingAddress"] == null ? true : alltrue([(input2["mailingAddress"]["type"] == null ? true : alltrue([(input2["mailingAddress"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input2["mailingAddress"]["type"]))]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["residenceAddress"] == null ? true : alltrue([(input2["residenceAddress"]["type"] == null ? true : alltrue([(input2["residenceAddress"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input2["residenceAddress"]["type"]))]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])])), (input0["schools"] == null ? true : alltrue([alltrue([for input2 in input0["schools"] : (input2 == null ? true : alltrue([(input2["address"] == null ? true : alltrue([(input2["address"]["type"] == null ? true : alltrue([(input2["address"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input2["address"]["type"]))]))])), (input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])])), (input0["teachers"] == null ? true : alltrue([alltrue([for input2 in input0["teachers"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))])), (input2["mailingAddress"] == null ? true : alltrue([(input2["mailingAddress"]["type"] == null ? true : alltrue([(input2["mailingAddress"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input2["mailingAddress"]["type"]))]))])), (input2["primaryRole"] == null ? true : alltrue([(input2["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input2["primaryRole"]))])), (input2["residenceAddress"] == null ? true : alltrue([(input2["residenceAddress"]["type"] == null ? true : alltrue([(input2["residenceAddress"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input2["residenceAddress"]["type"]))]))])), (input2["student"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : alltrue([(input2["student"]["gender"] == null ? true : contains(["female", "male", "other"], input2["student"]["gender"]))]))]))]))])]))]))])]))
    error_message = "classes: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = var.external_source == null ? true : contains(["sis", "manual"], var.external_source)
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

  validation {
    condition     = (var.users == null ? true : alltrue([alltrue([for input0 in var.users : (input0 == null ? true : alltrue([(input0["assignments"] == null ? true : alltrue([alltrue([for input2 in input0["assignments"] : (input2 == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : alltrue([(input2["addToCalendarAction"] == null ? true : contains(["none", "studentsAndPublisher", "studentsAndTeamOwners"], input2["addToCalendarAction"]))])), (input2["addedStudentAction"] == null ? true : alltrue([(input2["addedStudentAction"] == null ? true : contains(["none", "assignIfOpen"], input2["addedStudentAction"]))])), (input2["instructions"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : alltrue([(input2["instructions"]["contentType"] == null ? true : contains(["text", "html"], input2["instructions"]["contentType"]))]))]))]))])])), (input0["classes"] == null ? true : alltrue([alltrue([for input2 in input0["classes"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])])), (input0["externalSource"] == null ? true : alltrue([(input0["externalSource"] == null ? true : contains(["sis", "manual"], input0["externalSource"]))])), (input0["mailingAddress"] == null ? true : alltrue([(input0["mailingAddress"]["type"] == null ? true : alltrue([(input0["mailingAddress"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input0["mailingAddress"]["type"]))]))])), (input0["primaryRole"] == null ? true : alltrue([(input0["primaryRole"] == null ? true : contains(["student", "teacher", "none"], input0["primaryRole"]))])), (input0["relatedContacts"] == null ? true : alltrue([alltrue([for input2 in input0["relatedContacts"] : (input2 == null ? true : alltrue([(input2["relationship"] == null ? true : alltrue([(input2["relationship"] == null ? true : contains(["parent", "relative", "aide", "doctor", "guardian", "child", "other"], input2["relationship"]))]))]))])])), (input0["residenceAddress"] == null ? true : alltrue([(input0["residenceAddress"]["type"] == null ? true : alltrue([(input0["residenceAddress"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input0["residenceAddress"]["type"]))]))])), (input0["rubrics"] == null ? true : alltrue([alltrue([for input2 in input0["rubrics"] : (input2 == null ? true : alltrue([(input2["description"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : alltrue([(input2["description"]["contentType"] == null ? true : contains(["text", "html"], input2["description"]["contentType"]))]))]))]))])])), (input0["schools"] == null ? true : alltrue([alltrue([for input2 in input0["schools"] : (input2 == null ? true : alltrue([(input2["address"] == null ? true : alltrue([(input2["address"]["type"] == null ? true : alltrue([(input2["address"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], input2["address"]["type"]))]))])), (input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])])), (input0["student"] == null ? true : alltrue([(input0["student"]["gender"] == null ? true : alltrue([(input0["student"]["gender"] == null ? true : contains(["female", "male", "other"], input0["student"]["gender"]))]))])), (input0["taughtClasses"] == null ? true : alltrue([alltrue([for input2 in input0["taughtClasses"] : (input2 == null ? true : alltrue([(input2["externalSource"] == null ? true : alltrue([(input2["externalSource"] == null ? true : contains(["sis", "manual"], input2["externalSource"]))]))]))])]))]))])]))
    error_message = "users: nested required attributes must be non-null and enum values must be supported input members."
  }
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
