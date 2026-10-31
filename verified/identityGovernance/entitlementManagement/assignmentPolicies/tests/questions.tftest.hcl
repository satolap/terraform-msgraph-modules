# Requestor questions: text input and multiple choice, with localizations. A question
# that sets none of the newer attributes keeps the body of the previous release; see
# request_body_compatibility.tftest.hcl. Validations use expect_failures, which does not
# read the message, so tests/test_assignment_policy_reviews_questions.py checks the
# wording.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        custom_extension_stage_settings = []
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  displayName       = "Standard request policy"
}

# Setting the newer attributes to null, or type to its default, is the same as leaving
# them out: the question keeps the five keys it has always sent.
run "sends_the_original_keys_when_the_new_attributes_are_null" {
  command = apply

  variables {
    questions = [
      {
        text                       = "Why do you need this access?"
        isRequired                 = true
        sequence                   = 1
        type                       = "text_input"
        localizations              = null
        isSingleLineQuestion       = null
        regexPattern               = null
        isMultipleSelectionAllowed = null
        choices                    = null
      },
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body.questions) == jsonencode([
      {
        "@odata.type"    = "#microsoft.graph.accessPackageTextInputQuestion"
        isRequired       = true
        isAnswerEditable = true
        sequence         = 1
        text             = "Why do you need this access?"
      },
    ])
    error_message = "A text question without the newer attributes must send exactly the original five keys."
  }
}

run "sends_a_localized_multiple_choice_question" {
  command = apply

  variables {
    questions = [
      {
        type       = "multiple_choice"
        text       = "Which region do you work in?"
        isRequired = true
        sequence   = 1
        localizations = [
          { text = "In welcher Region arbeiten Sie?", languageCode = "de" },
          { text = "Dans quelle region travaillez-vous ?", languageCode = "fr-CH" },
        ]
        choices = [
          {
            text        = "Europe"
            actualValue = "EU"
            localizations = [
              { text = "Europa", languageCode = "de" },
              { text = "Europe", languageCode = "fr-CH" },
            ]
          },
          { text = "Americas", actualValue = "AM" },
        ]
      },
    ]
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body.questions) == jsonencode([
      {
        "@odata.type"              = "#microsoft.graph.accessPackageMultipleChoiceQuestion"
        isRequired                 = true
        isAnswerEditable           = true
        sequence                   = 1
        text                       = "Which region do you work in?"
        isMultipleSelectionAllowed = false
        localizations = [
          { text = "In welcher Region arbeiten Sie?", languageCode = "de" },
          { text = "Dans quelle region travaillez-vous ?", languageCode = "fr-CH" },
        ]
        choices = [
          {
            text        = "Europe"
            actualValue = "EU"
            localizations = [
              { text = "Europa", languageCode = "de" },
              { text = "Europe", languageCode = "fr-CH" },
            ]
          },
          { text = "Americas", actualValue = "AM" },
        ]
      },
    ])
    error_message = "A multiple choice question must send its type, choices with actualValue and localizations with languageCode, and isMultipleSelectionAllowed false by default."
  }
}

run "sends_multiple_selection_and_the_text_question_options" {
  command = apply

  variables {
    questions = [
      {
        type                       = "multiple_choice"
        text                       = "Which systems do you need?"
        sequence                   = 1
        isMultipleSelectionAllowed = true
        choices = [
          { text = "Ticketing", actualValue = "ticketing" },
          { text = "Reporting", actualValue = "reporting" },
        ]
      },
      {
        text                 = "Cost center"
        sequence             = 2
        isSingleLineQuestion = true
        regexPattern         = "^[0-9]{6}$"
        localizations        = [{ text = "Kostenstelle", languageCode = "de-CH" }]
      },
    ]
  }

  assert {
    condition     = msgraph_resource.assignment_policy.body.questions[0].isMultipleSelectionAllowed == true
    error_message = "isMultipleSelectionAllowed must be passed through."
  }

  assert {
    condition = jsonencode(msgraph_resource.assignment_policy.body.questions[1]) == jsonencode({
      "@odata.type"        = "#microsoft.graph.accessPackageTextInputQuestion"
      isRequired           = false
      isAnswerEditable     = true
      sequence             = 2
      text                 = "Cost center"
      isSingleLineQuestion = true
      regexPattern         = "^[0-9]{6}$"
      localizations        = [{ text = "Kostenstelle", languageCode = "de-CH" }]
    })
    error_message = "A text question must send isSingleLineQuestion, regexPattern and its localizations when they are set."
  }

  assert {
    condition     = !contains(keys(msgraph_resource.assignment_policy.body.questions[0]), "regexPattern") && !contains(keys(msgraph_resource.assignment_policy.body.questions[1]), "choices")
    error_message = "A question must not carry the properties of the other question type."
  }
}

run "sends_an_empty_localization_list_as_given" {
  command = apply

  variables {
    questions = [
      { text = "Why do you need this access?", localizations = [] },
    ]
  }

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.questions[0].localizations) == "[]"
    error_message = "An empty localizations list is set, so it must be sent as []."
  }
}

# Validations.
run "rejects_an_unknown_question_type" {
  command = plan

  variables {
    questions = [{ text = "Pick one", type = "accessPackageMultipleChoiceQuestion" }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_multiple_choice_question_without_choices" {
  command = plan

  variables {
    questions = [{ text = "Pick one", type = "multiple_choice" }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_multiple_choice_question_with_an_empty_choice_list" {
  command = plan

  variables {
    questions = [{ text = "Pick one", type = "multiple_choice", choices = [] }]
  }

  expect_failures = [var.questions]
}

run "rejects_choices_on_a_text_question" {
  command = plan

  variables {
    questions = [{ text = "Why?", choices = [{ text = "Because", actualValue = "because" }] }]
  }

  expect_failures = [var.questions]
}

run "rejects_multiple_selection_on_a_text_question" {
  command = plan

  variables {
    questions = [{ text = "Why?", isMultipleSelectionAllowed = true }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_regex_pattern_on_a_multiple_choice_question" {
  command = plan

  variables {
    questions = [{
      text         = "Pick one"
      type         = "multiple_choice"
      regexPattern = "^EU$"
      choices      = [{ text = "Europe", actualValue = "EU" }]
    }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_single_line_flag_on_a_multiple_choice_question" {
  command = plan

  variables {
    questions = [{
      text                 = "Pick one"
      type                 = "multiple_choice"
      isSingleLineQuestion = true
      choices              = [{ text = "Europe", actualValue = "EU" }]
    }]
  }

  expect_failures = [var.questions]
}

run "rejects_two_choices_with_the_same_actual_value" {
  command = plan

  variables {
    questions = [{
      text = "Pick one"
      type = "multiple_choice"
      choices = [
        { text = "Europe", actualValue = "EU" },
        { text = "European Union", actualValue = "EU" },
      ]
    }]
  }

  expect_failures = [var.questions]
}

run "rejects_an_empty_actual_value" {
  command = plan

  variables {
    questions = [{
      text    = "Pick one"
      type    = "multiple_choice"
      choices = [{ text = "Europe", actualValue = " " }]
    }]
  }

  expect_failures = [var.questions]
}

run "rejects_an_empty_localized_text" {
  command = plan

  variables {
    questions = [{ text = "Why?", localizations = [{ text = "", languageCode = "de" }] }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_language_name_as_language_code" {
  command = plan

  variables {
    questions = [{ text = "Why?", localizations = [{ text = "Warum?", languageCode = "german" }] }]
  }

  expect_failures = [var.questions]
}

run "rejects_an_underscore_in_a_choice_language_code" {
  command = plan

  variables {
    questions = [{
      text = "Pick one"
      type = "multiple_choice"
      choices = [
        { text = "Europe", actualValue = "EU", localizations = [{ text = "Europa", languageCode = "de_CH" }] },
      ]
    }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_language_code_named_twice" {
  command = plan

  variables {
    questions = [{
      text = "Why?"
      localizations = [
        { text = "Warum?", languageCode = "de-CH" },
        { text = "Wieso?", languageCode = "DE-ch" },
      ]
    }]
  }

  expect_failures = [var.questions]
}

run "rejects_a_choice_language_code_named_twice" {
  command = plan

  variables {
    questions = [{
      text = "Pick one"
      type = "multiple_choice"
      choices = [
        {
          text        = "Europe"
          actualValue = "EU"
          localizations = [
            { text = "Europa", languageCode = "de" },
            { text = "Europa", languageCode = "de" },
          ]
        },
      ]
    }]
  }

  expect_failures = [var.questions]
}
