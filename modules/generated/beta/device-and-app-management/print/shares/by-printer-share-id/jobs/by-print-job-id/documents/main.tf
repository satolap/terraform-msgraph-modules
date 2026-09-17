# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configuration"      = (var.configuration == null ? null : { for key0, value0 in { "@odata.type" = var.configuration["odata_type"], "collate" = var.configuration["collate"], "colorMode" = var.configuration["colorMode"], "copies" = var.configuration["copies"], "dpi" = var.configuration["dpi"], "duplexMode" = var.configuration["duplexMode"], "feedDirection" = var.configuration["feedDirection"], "feedOrientation" = var.configuration["feedOrientation"], "finishings" = (var.configuration["finishings"] == null ? null : [for item1 in var.configuration["finishings"] : item1 if item1 != null]), "fitPdfToPage" = var.configuration["fitPdfToPage"], "inputBin" = var.configuration["inputBin"], "margin" = var.configuration["margin"], "mediaSize" = var.configuration["mediaSize"], "mediaType" = var.configuration["mediaType"], "multipageLayout" = var.configuration["multipageLayout"], "orientation" = var.configuration["orientation"], "outputBin" = var.configuration["outputBin"], "pageRanges" = (var.configuration["pageRanges"] == null ? null : [for item1 in var.configuration["pageRanges"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "end" = item1["end"], "maximum" = item1["maximum"], "minimum" = item1["minimum"], "start" = item1["start"] } : key2 => value2 if value2 != null }) if item1 != null]), "pagesPerSheet" = var.configuration["pagesPerSheet"], "quality" = var.configuration["quality"], "scaling" = var.configuration["scaling"] } : key0 => value0 if value0 != null })
    "downloadedDateTime" = var.downloaded_date_time
    "@odata.type"        = var.odata_type
    "uploadedDateTime"   = var.uploaded_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/shares/${urlencode(var.printer_share_id)}/jobs/${urlencode(var.print_job_id)}/documents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
