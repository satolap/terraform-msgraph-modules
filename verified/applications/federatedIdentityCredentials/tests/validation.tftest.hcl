mock_provider "msgraph" {}

variables {
  application_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
  name           = "github-main"
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:example-org/example-repo:ref:refs/heads/main"
}

run "rejects_empty_application_id" {
  command = plan
  variables { application_id = "" }
  expect_failures = [var.application_id]
}

run "rejects_application_client_selector" {
  command = plan
  variables { application_id = "applications(appId=example)" }
  expect_failures = [var.application_id]
}

run "rejects_application_id_with_suffix" {
  command = plan
  variables { application_id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa\n" }
  expect_failures = [var.application_id]
}

run "rejects_empty_name" {
  command = plan
  variables { name = "" }
  expect_failures = [var.name]
}

run "rejects_short_name" {
  command = plan
  variables { name = "ab" }
  expect_failures = [var.name]
}

run "rejects_long_name" {
  command = plan
  variables { name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
  expect_failures = [var.name]
}

run "rejects_name_with_space" {
  command = plan
  variables { name = "github main" }
  expect_failures = [var.name]
}

run "rejects_name_with_slash" {
  command = plan
  variables { name = "github/main" }
  expect_failures = [var.name]
}

run "rejects_name_with_percent" {
  command = plan
  variables { name = "github%20main" }
  expect_failures = [var.name]
}

run "rejects_name_with_dot" {
  command = plan
  variables { name = "github.main" }
  expect_failures = [var.name]
}

run "rejects_name_with_leading_hyphen" {
  command = plan
  variables { name = "-github-main" }
  expect_failures = [var.name]
}

run "rejects_name_with_unicode" {
  command = plan
  variables { name = "gith\u00fcb-main" }
  expect_failures = [var.name]
}

run "rejects_name_with_newline" {
  command = plan
  variables { name = "github-main\n" }
  expect_failures = [var.name]
}

run "rejects_empty_issuer" {
  command = plan
  variables { issuer = "" }
  expect_failures = [var.issuer]
}

run "rejects_http_issuer" {
  command = plan
  variables { issuer = "http://issuer.example" }
  expect_failures = [var.issuer]
}

run "rejects_relative_issuer" {
  command = plan
  variables { issuer = "issuer.example" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_without_host" {
  command = plan
  variables { issuer = "https:///path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_userinfo" {
  command = plan
  variables { issuer = "https://user@issuer.example/path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_query" {
  command = plan
  variables { issuer = "https://issuer.example/path?query=yes" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_fragment" {
  command = plan
  variables { issuer = "https://issuer.example/path#fragment" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_space" {
  command = plan
  variables { issuer = "https://issuer.example/some path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_newline" {
  command = plan
  variables { issuer = "https://issuer.example/\n" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_backslash" {
  command = plan
  variables { issuer = "https://issuer.example/a\\b" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_bad_host" {
  command = plan
  variables { issuer = "https://-issuer.example/path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_empty_label" {
  command = plan
  variables { issuer = "https://issuer..example/path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_zero_port" {
  command = plan
  variables { issuer = "https://issuer.example:0/path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_large_port" {
  command = plan
  variables { issuer = "https://issuer.example:65536/path" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_zero_host_port_despite_path_number" {
  command = plan
  variables { issuer = "https://issuer.example:0/tenant:443/v2.0" }
  expect_failures = [var.issuer]
}

run "rejects_issuer_large_host_port_without_path" {
  command = plan
  variables { issuer = "https://issuer.example:65536" }
  expect_failures = [var.issuer]
}

run "accepts_issuer_zero_in_path" {
  command = plan
  variables { issuer = "https://issuer.example/tenant:0/v2.0" }
  assert {
    condition     = msgraph_resource.credential.body.issuer == var.issuer
    error_message = "A colon followed by digits in the issuer path is not a host port and must be preserved."
  }
}

run "accepts_issuer_large_number_at_path_end" {
  command = plan
  variables { issuer = "https://issuer.example/tenant:65536" }
  assert {
    condition     = msgraph_resource.credential.body.issuer == var.issuer
    error_message = "Port limits must not restrict numeric text at the end of an issuer path."
  }
}

run "accepts_issuer_valid_host_port_with_zero_in_path" {
  command = plan
  variables { issuer = "https://issuer.example:443/tenant:0/v2.0" }
  assert {
    condition     = msgraph_resource.credential.body.issuer == var.issuer
    error_message = "Validate the host port independently of numeric path segments."
  }
}

run "rejects_long_issuer" {
  command = plan
  variables { issuer = "https://issuer.example/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
  expect_failures = [var.issuer]
}

run "rejects_empty_subject" {
  command = plan
  variables { subject = "" }
  expect_failures = [var.subject]
}

run "rejects_whitespace_subject" {
  command = plan
  variables { subject = "  " }
  expect_failures = [var.subject]
}

run "rejects_long_subject" {
  command = plan
  variables { subject = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
  expect_failures = [var.subject]
}

run "rejects_empty_audiences" {
  command = plan
  variables { audiences = [] }
  expect_failures = [var.audiences]
}

run "rejects_multiple_audiences" {
  command = plan
  variables { audiences = ["first", "second"] }
  expect_failures = [var.audiences]
}

run "rejects_null_audience" {
  command = plan
  variables { audiences = [null] }
  expect_failures = [var.audiences]
}

run "rejects_empty_audience" {
  command = plan
  variables { audiences = [""] }
  expect_failures = [var.audiences]
}

run "rejects_whitespace_audience" {
  command = plan
  variables { audiences = [" "] }
  expect_failures = [var.audiences]
}

run "rejects_long_audience" {
  command = plan
  variables { audiences = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"] }
  expect_failures = [var.audiences]
}

run "rejects_long_description" {
  command = plan
  variables { description = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
  expect_failures = [var.description]
}

run "accepts_minimum_name" {
  command = plan
  variables {
    name = "a_-"
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}

run "accepts_maximum_name" {
  command = plan
  variables {
    name = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}

run "accepts_maximum_strings" {
  command = plan
  variables {
    issuer      = "https://issuer.example/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    subject     = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    audiences   = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"]
    description = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}

run "accepts_issuer_port_and_trailing_slash" {
  command = plan
  variables {
    issuer = "https://issuer.example:443/cluster/"
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}

run "accepts_literal_subject_case" {
  command = plan
  variables {
    subject = "repo:Example-Org/Example-Repo:environment:Production"
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}

run "accepts_null_description" {
  command = plan
  variables {
    description = null
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}

run "accepts_null_audiences_use_default" {
  command = plan
  variables {
    audiences = null
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body.audiences) == jsonencode(var.audiences)
    error_message = "Accepted values must preserve their configured audience, including the default for null."
  }
}
