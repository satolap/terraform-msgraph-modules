# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "blackAndWhitePageCount"         = var.black_and_white_page_count
    "colorPageCount"                 = var.color_page_count
    "completedBlackAndWhiteJobCount" = var.completed_black_and_white_job_count
    "completedColorJobCount"         = var.completed_color_job_count
    "completedJobCount"              = var.completed_job_count
    "doubleSidedSheetCount"          = var.double_sided_sheet_count
    "incompleteJobCount"             = var.incomplete_job_count
    "mediaSheetCount"                = var.media_sheet_count
    "@odata.type"                    = var.odata_type
    "pageCount"                      = var.page_count
    "printerId"                      = var.printer_id
    "printerName"                    = var.printer_name
    "singleSidedSheetCount"          = var.single_sided_sheet_count
    "usageDate"                      = var.usage_date
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/monthlyPrintUsageByPrinter"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
