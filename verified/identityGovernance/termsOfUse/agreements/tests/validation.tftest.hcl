mock_provider "msgraph" {}

# Synthetic content only: the base64 text below decodes to a few ASCII characters that start with
# the PDF header. No real document is part of this repository.
variables {
  display_name = "Terms of use for guests"

  default_file = {
    language       = "en"
    file_name      = "TOU.pdf"
    content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
  }
}

run "accepts_the_minimal_configuration" {
  command = plan

  assert {
    condition     = msgraph_resource.agreement.body.isViewingBeforeAcceptanceRequired == false && length(msgraph_resource.agreement.body.files) == 1
    error_message = "An agreement with one default file must plan."
  }
}

run "rejects_an_empty_display_name" {
  command = plan
  variables {
    display_name = "  "
  }
  expect_failures = [var.display_name]
}

run "rejects_a_language_that_is_not_a_language_tag" {
  command = plan
  variables {
    default_file = {
      language       = "english"
      file_name      = "TOU.pdf"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }
  expect_failures = [var.default_file]
}

run "accepts_country_and_script_subtags" {
  command = plan
  variables {
    default_file = {
      language       = "zh-Hant-TW"
      file_name      = "TOU.pdf"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }

  assert {
    condition     = msgraph_resource.agreement.body.files[0].language == "zh-Hant-TW"
    error_message = "A BCP-47 tag with a script and a region must be accepted."
  }
}

run "rejects_a_file_name_with_a_path_separator" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "../TOU.pdf"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }
  expect_failures = [var.default_file]
}

run "rejects_an_empty_file_display_name" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "TOU.pdf"
      display_name   = " "
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }
  expect_failures = [var.default_file]
}

run "rejects_content_that_is_not_base64" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "TOU.pdf"
      content_base64 = "JVBERi0 not base64!"
    }
  }
  expect_failures = [var.default_file]
}

run "rejects_unpadded_base64" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "TOU.pdf"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g"
    }
  }
  expect_failures = [var.default_file]
}

run "rejects_content_that_is_not_a_pdf" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "TOU.pdf"
      content_base64 = "bm90IGEgcGRmIGF0IGFsbCEh"
    }
  }
  expect_failures = [var.default_file]
}

run "rejects_content_over_the_size_limit" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "TOU.pdf"
      content_base64 = "JVBERi0A${join("", [for i in range(699) : join("", [for j in range(1000) : "AAAA"])])}${join("", [for j in range(48) : "AAAA"])}AAAA"
    }
  }
  expect_failures = [var.default_file]
}

run "accepts_content_at_the_size_limit" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      file_name      = "TOU.pdf"
      content_base64 = "JVBERi0A${join("", [for i in range(699) : join("", [for j in range(1000) : "AAAA"])])}${join("", [for j in range(48) : "AAAA"])}AAA="
    }
  }

  assert {
    condition     = length(msgraph_resource.agreement.body.files) == 1
    error_message = "Content that decodes to exactly 2 MiB must be accepted."
  }
}

run "rejects_an_additional_file_key_that_is_not_a_name" {
  command = plan
  variables {
    additional_files = {
      "Not A Key" = {
        language       = "fr"
        file_name      = "TOU-fr.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }
  expect_failures = [var.additional_files]
}

run "rejects_an_additional_file_with_bad_content" {
  command = plan
  variables {
    additional_files = {
      french = {
        language       = "fr"
        file_name      = "TOU-fr.pdf"
        content_base64 = "bm90IGEgcGRmIGF0IGFsbCEh"
      }
    }
  }
  expect_failures = [var.additional_files]
}

run "rejects_an_additional_file_with_a_bad_language" {
  command = plan
  variables {
    additional_files = {
      french = {
        language       = "f"
        file_name      = "TOU-fr.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }
  expect_failures = [var.additional_files]
}

run "rejects_a_language_repeated_in_another_case" {
  command = plan
  variables {
    additional_files = {
      english_again = {
        language       = "EN"
        file_name      = "TOU-2.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }
  expect_failures = [msgraph_resource.agreement]
}

run "rejects_two_additional_files_with_the_same_language" {
  command = plan
  variables {
    additional_files = {
      first = {
        language       = "fr"
        file_name      = "TOU-fr.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
      second = {
        language       = "fr"
        file_name      = "TOU-fr-2.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGdlcm1hbg=="
      }
    }
  }
  expect_failures = [msgraph_resource.agreement]
}
