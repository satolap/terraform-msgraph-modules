# Nothing here calls Graph: the mock provider records the request bodies. The runs share one state
# in file order. The mock gives every created agreement a new random ID, so a replacement shows as
# a different ID; an in-place update keeps it. The PDFs are a few synthetic ASCII bytes that start
# with the PDF header.
mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      output = {
        id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
      }
    }
  }
}

variables {
  displayName                       = "Terms of use for guests"
  isViewingBeforeAcceptanceRequired = true

  default_file = {
    language       = "en"
    fileName       = "TOU.pdf"
    displayName    = "Terms of use for guests"
    content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
  }
}

run "creates_the_agreement" {
  command = apply

  assert {
    condition     = msgraph_resource.agreement.url == "identityGovernance/termsOfUse/agreements" && msgraph_resource.agreement.api_version == "v1.0"
    error_message = "The agreement must be created against the v1.0 identityGovernance/termsOfUse/agreements collection."
  }

  assert {
    condition     = toset(keys(msgraph_resource.agreement.body)) == toset(["displayName", "isViewingBeforeAcceptanceRequired", "files"])
    error_message = "The create body must carry only displayName, isViewingBeforeAcceptanceRequired and files."
  }

  assert {
    condition     = msgraph_resource.agreement.body.displayName == "Terms of use for guests" && msgraph_resource.agreement.body.isViewingBeforeAcceptanceRequired == true
    error_message = "The agreement properties must be sent as configured."
  }

  assert {
    condition = (
      length(msgraph_resource.agreement.body.files) == 1
      && msgraph_resource.agreement.body.files[0].fileName == "TOU.pdf"
      && msgraph_resource.agreement.body.files[0].language == "en"
      && msgraph_resource.agreement.body.files[0].isDefault == true
      && msgraph_resource.agreement.body.files[0].displayName == "Terms of use for guests"
      && toset(keys(msgraph_resource.agreement.body.files[0].fileData)) == toset(["data"])
    )
    error_message = "The create request must carry the default file with isDefault true and the PDF in fileData.data."
  }

  assert {
    condition     = nonsensitive(msgraph_resource.agreement.body.files[0].fileData.data == "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g=")
    error_message = "The PDF content must be sent as the base64 text that was configured."
  }

  assert {
    condition     = length(msgraph_resource_action.file) == 0 && length(terraform_data.file_applied) == 0
    error_message = "Without additional_files no file is posted."
  }

  assert {
    condition     = jsonencode(output.file_languages) == jsonencode(["en"]) && output.default_file_language == "en" && length(output.additional_file_ids) == 0
    error_message = "The outputs must list the default file only."
  }

  assert {
    condition     = output.content_sha256["en"] == sha256("JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g=")
    error_message = "content_sha256 must be the SHA-256 of the base64 text."
  }

  assert {
    condition     = !can(regex("JVBERi0", jsonencode(output.request_summary)))
    error_message = "The request summary must not carry the PDF content."
  }
}

run "updates_name_and_viewing_requirement_in_place" {
  command = apply

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
  }

  assert {
    condition     = output.id == run.creates_the_agreement.id
    error_message = "displayName and isViewingBeforeAcceptanceRequired are documented for PATCH: the agreement keeps its ID."
  }

  assert {
    condition     = msgraph_resource.agreement.body.displayName == "Terms of use for guests (2026)" && msgraph_resource.agreement.body.isViewingBeforeAcceptanceRequired == false
    error_message = "The update must carry the new values."
  }
}

run "refuses_a_changed_default_file_content" {
  command = plan

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    default_file = {
      language       = "en"
      fileName       = "TOU.pdf"
      displayName    = "Terms of use for guests"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2ggdjI="
    }
  }

  expect_failures = [terraform_data.guard]
}

run "refuses_a_changed_default_language" {
  command = plan

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    default_file = {
      language       = "en-US"
      fileName       = "TOU.pdf"
      displayName    = "Terms of use for guests"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }

  expect_failures = [terraform_data.guard]
}

run "adds_a_localized_file_with_one_post" {
  command = apply

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions generales"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }

  assert {
    condition     = msgraph_resource_action.file["french"].method == "POST" && msgraph_resource_action.file["french"].api_version == "v1.0"
    error_message = "A localized file is added with a POST."
  }

  assert {
    condition     = msgraph_resource_action.file["french"].resource_url == "identityGovernance/termsOfUse/agreements/${run.creates_the_agreement.id}/files"
    error_message = "The file must be posted to the files collection of the agreement."
  }

  assert {
    condition = (
      msgraph_resource_action.file["french"].body.fileName == "TOU-fr.pdf"
      && msgraph_resource_action.file["french"].body.language == "fr-FR"
      && msgraph_resource_action.file["french"].body.isDefault == false
      && msgraph_resource_action.file["french"].body.isMajorVersion == false
      && msgraph_resource_action.file["french"].body.displayName == "Conditions generales"
      && nonsensitive(msgraph_resource_action.file["french"].body.fileData.data == "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA==")
    )
    error_message = "The file request must carry the documented properties, isDefault false and the configured PDF."
  }

  assert {
    condition     = output.id == run.creates_the_agreement.id && jsonencode(output.file_languages) == jsonencode(["en", "fr-fr"])
    error_message = "Adding a file must not change the agreement ID."
  }

  assert {
    condition     = terraform_data.file_applied["french"].input.file_id == msgraph_resource_action.file["french"].output.id
    error_message = "The applied-file record must read the ID returned by the POST, so that it exists only after the POST succeeded."
  }

  assert {
    condition     = output.additional_file_ids == { french = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb" }
    error_message = "The ID of the added file must be exported by key."
  }
}

run "refuses_a_changed_additional_file" {
  command = plan

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions generales"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
        isMajorVersion = true
      }
    }
  }

  expect_failures = [terraform_data.guard]
}

run "adds_a_second_file_and_keeps_the_first_unchanged" {
  command = apply

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions generales"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
      german = {
        language       = "de"
        fileName       = "TOU-de.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGdlcm1hbg=="
        isMajorVersion = true
      }
    }
  }

  assert {
    condition     = msgraph_resource_action.file["german"].body.isMajorVersion == true && !contains(keys(msgraph_resource_action.file["german"].body), "displayName")
    error_message = "A null file displayName must be left out and isMajorVersion must be sent as configured."
  }

  assert {
    condition     = jsonencode(output.file_languages) == jsonencode(["de", "en", "fr-fr"]) && output.id == run.creates_the_agreement.id
    error_message = "Both languages must be listed and the agreement must keep its ID."
  }
}

run "forgets_a_removed_file_without_deleting_anything" {
  command = apply

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions generales"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }

  assert {
    condition     = length(msgraph_resource_action.file) == 1 && output.id == run.creates_the_agreement.id
    error_message = "Removing a key stops tracking the file; the agreement stays."
  }
}

run "replaces_the_agreement_only_when_asked_to" {
  command = apply

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    default_file = {
      language       = "en"
      fileName       = "TOU.pdf"
      displayName    = "Terms of use for guests"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2ggdjI="
    }
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions generales"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }

  plan_options {
    replace = [msgraph_resource.agreement]
  }

  assert {
    condition     = output.id != run.creates_the_agreement.id
    error_message = "A replacement creates a new agreement with a new ID."
  }

  assert {
    condition     = nonsensitive(msgraph_resource.agreement.body.files[0].fileData.data == "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2ggdjI=")
    error_message = "The replacement must be created with the new default file."
  }

  assert {
    condition     = output.content_sha256["en"] == sha256("JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2ggdjI=") && jsonencode(output.file_languages) == jsonencode(["en", "fr-fr"])
    error_message = "The replacement must record the new files, and the additional file must be posted to the new agreement."
  }
}

run "accepts_the_new_content_after_the_replacement" {
  command = plan

  variables {
    displayName                       = "Terms of use for guests (2026)"
    isViewingBeforeAcceptanceRequired = false
    default_file = {
      language       = "en"
      fileName       = "TOU.pdf"
      displayName    = "Terms of use for guests"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2ggdjI="
    }
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions generales"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }

  assert {
    condition     = output.content_sha256["en"] == sha256("JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2ggdjI=")
    error_message = "After the replacement the new content is the recorded one."
  }
}
