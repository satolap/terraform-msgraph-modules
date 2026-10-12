variable "capabilities" {
  description = "The capabilities of the printer/printerShare."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.printerCapabilities")
    bottomMargins = optional(list(number))
    collation     = optional(bool)
    colorModes    = optional(list(string))
    contentTypes  = optional(list(string))
    copiesPerJob = optional(object({
      odata_type = optional(string, "#microsoft.graph.integerRange")
      end        = optional(number)
      start      = optional(number)
    }))
    dpis                 = optional(list(number))
    duplexModes          = optional(list(string))
    feedOrientations     = optional(list(string))
    finishings           = optional(list(string))
    inputBins            = optional(list(string))
    isPageRangeSupported = optional(bool)
    leftMargins          = optional(list(number))
    mediaColors          = optional(list(string))
    mediaSizes           = optional(list(string))
    mediaTypes           = optional(list(string))
    multipageLayouts     = optional(list(string))
    orientations         = optional(list(string))
    outputBins           = optional(list(string))
    pagesPerSheet        = optional(list(number))
    qualities            = optional(list(string))
    rightMargins         = optional(list(number))
    scalings             = optional(list(string))
    supportsFitPdfToPage = optional(bool)
    topMargins           = optional(list(number))
  })
  default = null
}

variable "connectors" {
  description = "The connectors that are associated with the printer."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.printConnector")
    appVersion               = optional(string)
    displayName              = optional(string)
    fullyQualifiedDomainName = optional(string)
    location = optional(object({
      odata_type       = optional(string, "#microsoft.graph.printerLocation")
      altitudeInMeters = optional(number)
      building         = optional(string)
      city             = optional(string)
      countryOrRegion  = optional(string)
      floor            = optional(string)
      floorDescription = optional(string)
      latitude         = optional(any)
      longitude        = optional(any)
      organization     = optional(list(string))
      postalCode       = optional(string)
      roomDescription  = optional(string)
      roomName         = optional(string)
      site             = optional(string)
      stateOrProvince  = optional(string)
      streetAddress    = optional(string)
      subdivision      = optional(list(string))
      subunit          = optional(list(string))
    }))
    operatingSystem    = optional(string)
    registeredDateTime = optional(string)
  }))
  default = null
}

variable "defaults" {
  description = "The default print settings of printer/printerShare."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.printerDefaults")
    colorMode       = optional(string)
    contentType     = optional(string)
    copiesPerJob    = optional(number)
    dpi             = optional(number)
    duplexMode      = optional(string)
    finishings      = optional(list(string))
    fitPdfToPage    = optional(bool)
    inputBin        = optional(string)
    mediaColor      = optional(string)
    mediaSize       = optional(string)
    mediaType       = optional(string)
    multipageLayout = optional(string)
    orientation     = optional(string)
    outputBin       = optional(string)
    pagesPerSheet   = optional(number)
    quality         = optional(string)
    scaling         = optional(string)
  })
  default = null
}

variable "display_name" {
  description = "The name of the printer/printerShare."
  type        = string
  default     = null
}

variable "is_accepting_jobs" {
  description = "Specifies whether the printer/printerShare is currently accepting new print jobs."
  type        = bool
  default     = null
}

variable "jobs" {
  description = "The list of jobs that are queued for printing by the printer/printerShare."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.printJob")
    configuration = optional(object({
      odata_type   = optional(string, "#microsoft.graph.printJobConfiguration")
      collate      = optional(bool)
      finishings   = optional(list(string))
      fitPdfToPage = optional(bool)
      inputBin     = optional(string)
      margin = optional(object({
        odata_type = optional(string, "#microsoft.graph.printMargin")
        bottom     = optional(number)
        left       = optional(number)
        right      = optional(number)
        top        = optional(number)
      }))
      mediaSize       = optional(string)
      mediaType       = optional(string)
      multipageLayout = optional(string)
      orientation     = optional(string)
      outputBin       = optional(string)
      pagesPerSheet   = optional(number)
      scaling         = optional(string)
    }))
    createdBy = optional(object({
      odata_type        = optional(string, "#microsoft.graph.userIdentity")
      displayName       = optional(string)
      id                = optional(string)
      ipAddress         = optional(string)
      userPrincipalName = optional(string)
    }))
    documents = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.printDocument")
    })))
    isFetchable    = optional(bool)
    redirectedFrom = optional(string)
    redirectedTo   = optional(string)
    status = optional(object({
      odata_type = optional(string, "#microsoft.graph.printJobStatus")
      state      = optional(string)
    }))
    tasks = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.printTask")
      definition = optional(object({
        odata_type  = optional(string, "#microsoft.graph.printTaskDefinition")
        createdBy   = optional(any)
        displayName = optional(string)
      }))
      status = optional(object({
        odata_type  = optional(string, "#microsoft.graph.printTaskStatus")
        description = optional(string)
        state       = optional(string)
      }))
      trigger = optional(object({
        odata_type = optional(string, "#microsoft.graph.printTaskTrigger")
        definition = optional(any)
        event      = optional(string)
      }))
    })))
  }))
  default = null
}

variable "location" {
  description = "The physical and/or organizational location of the printer/printerShare."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.printerLocation")
    altitudeInMeters = optional(number)
    building         = optional(string)
    city             = optional(string)
    countryOrRegion  = optional(string)
    floor            = optional(string)
    floorDescription = optional(string)
    latitude         = optional(any)
    longitude        = optional(any)
    organization     = optional(list(string))
    postalCode       = optional(string)
    roomDescription  = optional(string)
    roomName         = optional(string)
    site             = optional(string)
    stateOrProvince  = optional(string)
    streetAddress    = optional(string)
    subdivision      = optional(list(string))
    subunit          = optional(list(string))
  })
  default = null
}

variable "manufacturer" {
  description = "The manufacturer of the printer/printerShare."
  type        = string
  default     = null
}

variable "model" {
  description = "The model name of the printer/printerShare."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printer"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.printerStatus")
    state      = optional(string)
  })
  default = null
}

variable "task_triggers" {
  description = "A list of task triggers that are associated with the printer."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.printTaskTrigger")
    definition = optional(object({
      odata_type = optional(string, "#microsoft.graph.printTaskDefinition")
      createdBy = optional(object({
        odata_type           = optional(string, "#microsoft.graph.appIdentity")
        appId                = optional(string)
        displayName          = optional(string)
        servicePrincipalId   = optional(string)
        servicePrincipalName = optional(string)
      }))
      displayName = optional(string)
    }))
    event = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["hasPhysicalDevice", "id", "isShared", "lastSeenDateTime", "registeredDateTime", "shares"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
