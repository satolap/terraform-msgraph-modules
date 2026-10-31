# A caller upgrading from v4.0.0 who keeps a snake_case nested name must fail at plan time:
# the object type would otherwise drop the name and fall back to its default (a file whose
# display name or major-version flag is silently lost). Each rejection run is paired with an
# accepting run without the legacy name.
mock_provider "msgraph" {}

variables {
  displayName = "Terms of use for guests"

  default_file = {
    language       = "en"
    fileName       = "TOU.pdf"
    content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
  }
}

run "graph_names_are_accepted" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      fileName       = "TOU.pdf"
      displayName    = "Terms"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
        isMajorVersion = true
      }
    }
  }
}

run "default_file_rejects_display_name" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      fileName       = "TOU.pdf"
      display_name   = "Terms"
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }
  expect_failures = [var.default_file]
}

run "default_file_accepts_explicit_null_legacy_names" {
  command = plan
  variables {
    default_file = {
      language       = "en"
      fileName       = "TOU.pdf"
      display_name   = null
      content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
    }
  }
}

run "additional_files_reject_display_name" {
  command = plan
  variables {
    additional_files = {
      french = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        display_name   = "Conditions"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }
  expect_failures = [var.additional_files]
}

run "additional_files_reject_is_major_version" {
  command = plan
  variables {
    additional_files = {
      french = {
        language         = "fr-FR"
        fileName         = "TOU-fr.pdf"
        content_base64   = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
        is_major_version = true
      }
    }
  }
  expect_failures = [var.additional_files]
}

run "additional_files_accept_explicit_null_legacy_names" {
  command = plan
  variables {
    additional_files = {
      french = {
        language         = "fr-FR"
        fileName         = "TOU-fr.pdf"
        content_base64   = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
        display_name     = null
        is_major_version = null
      }
    }
  }
}

run "additional_files_accept_legacy_looking_keys" {
  command = plan
  variables {
    additional_files = {
      display_name = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        displayName    = "Conditions"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
      is_major_version = {
        language       = "de-DE"
        fileName       = "TOU-de.pdf"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGdlcm1hbg=="
        isMajorVersion = true
      }
    }
  }
}

run "additional_files_reject_a_legacy_name_under_a_legacy_looking_key" {
  command = plan
  variables {
    additional_files = {
      display_name = {
        language       = "fr-FR"
        fileName       = "TOU-fr.pdf"
        display_name   = "Conditions"
        content_base64 = "JVBERi0xLjQgc3ludGhldGljIGZyZW5jaA=="
      }
    }
  }
  expect_failures = [var.additional_files]
}