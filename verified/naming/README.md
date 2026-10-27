# naming

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Renders object names from a **naming convention**: one template per name, filled from a
set of token values. The module is pure Terraform. It declares no provider, no resource and
no data source, so it calls no API, needs no credentials and changes nothing in a tenant.

Composite modules use it to name the objects they create, and expose its `templates` so
that a caller can apply its own convention. It works just as well for names outside
Microsoft Graph, such as Azure resource names.

What the module does, and what it does not:

- **One convention, many names.** `templates` maps a name of your choice (`catalog`,
  `owners_group`) to a template, and `names` returns the rendered name under the same key.
- **Filters normalize values.** `{organization|ascii|alnum}` turns `Zürich Søn & Co` into
  `ZurichSonCo`, for example for a mail nickname.
- **Optional segments drop cleanly.** `kv-{region}[-{workload}]-{instance}` renders
  `kv-weu-001` when `workload` is empty, without a doubled hyphen.
- **The convention's parts can be checked.** `token_rules` makes a token required, limits it
  to allowed values such as environment codes, or gives it a pattern.
- **Names know their object's limits.** `kinds` declares what a name is for, such as a
  group's mail nickname, and checks it against the limits that the verified module or
  Microsoft Learn sets for that object.
- **One convention, enforced downstream.** `patterns` derives a regular expression per
  template from the convention itself. Pass it to a verified module's `name_pattern`, and
  that module rejects names that do not follow the convention.
- **Mistakes fail the plan.** A token that is not set or breaks its rule, a required
  placeholder that renders empty, an empty name, or a name that breaks its kind or its
  `constraints` fails the plan with a message that names the token or the template.
- **The convention is the caller's.** The module ships no convention. Segments, separators
  and codes are a governance decision that belongs in the calling configuration.
- **Names are not checked against a tenant.** The module does not know whether a name is
  already taken. The module that creates the object, or Microsoft Graph, decides that.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "partner_names" {
  source  = "satolap/modules/msgraph//verified/naming"
  version = "<version>"

  templates = {
    catalog         = "Partners/{organization}"
    access_package  = "{organization} guest access"
    guests_group    = "{organization|ascii|alnum}-guests"
    guests_nickname = "{organization|ascii|slug}-guests"
  }

  tokens = {
    organization = "Fabrikam Café"
  }

  kinds = {
    catalog         = "catalog"
    access_package  = "access_package"
    guests_group    = "group"
    guests_nickname = "group_mail_nickname"
  }
}

module "guests_group" {
  source  = "satolap/modules/msgraph//verified/groups"
  version = "<version>"

  display_name          = module.partner_names.names.guests_group       # FabrikamCafe-guests
  mail_nickname         = module.partner_names.names.guests_nickname    # fabrikam-cafe-guests
  name_pattern          = module.partner_names.patterns.guests_group    # ^[A-Za-z0-9]+-guests$
  mail_nickname_pattern = module.partner_names.patterns.guests_nickname # ^[a-z0-9]+(?:-[a-z0-9]+)*-guests$
}
```

### An Azure-style convention

Optional segments reproduce conventions that join components with a separator and leave
out the empty ones:

```hcl
module "azure_names" {
  source  = "satolap/modules/msgraph//verified/naming"
  version = "<version>"

  templates = {
    key_vault       = "kv-{company|lower}-{region}[-{workload}][-{environment}]-{instance}"
    storage_account = "st{company|lower}{region}[{workload}][{environment}]{instance}"
  }

  tokens = {
    company     = "CT01"
    region      = "weu"
    workload    = "data"
    environment = "" # left out, with its separator
    instance    = "001"
  }

  constraints = {
    key_vault       = { max_length = 24 }
    storage_account = { max_length = 24, pattern = "^[a-z0-9]+$" }
  }
}

# names = { key_vault = "kv-ct01-weu-data-001", storage_account = "stct01weudata001" }
```

## Template syntax

| Syntax | Meaning |
| --- | --- |
| `text` | Literal text, rendered as written. `\|` is literal outside a placeholder. |
| `{token}` | The value of `token` from `tokens`. Token names use lower case letters, digits and underscores and start with a letter. |
| `{token\|filter\|filter}` | The value after up to four filters, applied from left to right. |
| `[text {token} text]` | An optional segment: rendered only when every placeholder in it renders non-empty, otherwise left out with its literal text. It must hold a placeholder and cannot nest. |
| `{lbrace}`, `{rbrace}`, `{lbracket}`, `{rbracket}` | Built-in tokens that insert `{`, `}`, `[` and `]`, which the syntax otherwise reserves. These names cannot be set in `tokens`. |

A placeholder outside an optional segment must render non-empty, and the whole name must
not be empty; otherwise the plan fails. A null token value counts as empty.

### Filters

| Filter | Effect | `Zürich Søn & Co.` becomes |
| --- | --- | --- |
| `lower` | Lower case | `zürich søn & co.` |
| `upper` | Upper case | `ZÜRICH SØN & CO.` |
| `trim` | Removes leading and trailing whitespace | `Zürich Søn & Co.` |
| `ascii` | Replaces letters through the transliteration table, then drops every character outside ASCII | `Zurich Son & Co.` |
| `alnum` | Keeps letters and digits of every script, drops everything else | `ZürichSønCo` |
| `nospace` | Removes all whitespace, including no-break spaces | `ZürichSøn&Co.` |
| `slug` | Lower case, each run of characters other than letters and digits becomes `-`, then trims `-` at both ends | `zürich-søn-co` |

Combine them: `ascii|alnum` gives `ZurichSonCo`, and `ascii|slug` gives `zurich-son-co`.
`alnum` and `slug` keep non-Latin letters; put `ascii` first to get ASCII only.

### Transliteration

`ascii` looks each character up in a built-in table before it drops the rest. The table maps
the letters with diacritics of Latin-1 Supplement and Latin Extended-A, and `Ș` and `Ț`, to
their base letters (`é` to `e`, `ł` to `l`, `ø` to `o`), and spells out `ß`, `æ`, `œ`, `þ`
and `ĳ` as `ss`, `ae`, `oe`, `th` and `ij`, in upper case too. Terraform normalizes strings
to NFC, so a base letter followed by a combining mark is mapped like the precomposed letter.
Letters of other scripts have no entry and are dropped.

`transliterations` is merged over the table. Each key is one character of one Unicode code point, because the filter looks characters up one code point at a time; an emoji with a skin tone, for example, is two. Use it to follow a local convention, or to drop
a character with an empty replacement:

```hcl
transliterations = {
  "ä" = "ae"
  "ö" = "oe"
  "ü" = "ue"
  "Ä" = "Ae"
  "Ö" = "Oe"
  "Ü" = "Ue"
}
```

Tools that decompose to NFKD and drop the marks, a common normalization in scripts, drop
`ß`, `æ`, `œ`, `ø`, `ł`, `đ` and `þ` entirely, because these letters have no decomposition.
To reproduce names that such a tool made, map those letters to `""`.

### Constraints

`constraints` takes a rule per template key: `max_length`, in characters, and `pattern`, an
RE2 regular expression that is not anchored unless it says so (`^...$`). The plan fails when
a rendered name breaks a rule, or when `constraints` names a template that does not exist.
Use it for rules of your own, or for names that no kind covers, such as descriptions or
Azure resource names: `kinds` already sets the limits of the objects that the verified
modules create.

### Name kinds

`kinds` maps a template key to the kind of name it renders. The plan fails when the name is
blank, longer than its kind allows, or holds characters that its kind does not allow, and
the message names the template, its kind and the rule. A kind adds to `constraints`: set both
when your convention is stricter than the object.

```hcl
kinds = {
  catalog         = "catalog"
  guests_group    = "group"
  guests_nickname = "group_mail_nickname"
}
```

Each kind mirrors the validation of the verified module that takes the name, so a name that
passes its kind also passes that module. Where the module sets no limit, Microsoft Learn is
the source, or the kind only rejects a blank name.

| Kind | Name | Maximum length | Characters | Source |
| --- | --- | --- | --- | --- |
| `access_package` | Access package display name | 90 | any | `verified/identity-governance/entitlement-management/access-packages` |
| `access_review` | Access review display name | none | any | `verified/identityGovernance/accessReviews/definitions` |
| `administrative_unit` | Administrative unit display name | 256 | any | `verified/directory/administrative-units` |
| `application` | Application display name | 120 | any | `verified/applications` |
| `assignment_policy` | Assignment policy display name | 90 | any | `verified/identity-governance/entitlement-management/assignment-policies` |
| `authentication_strength` | Custom authentication strength display name | none | any | `verified/policies/authenticationStrengthPolicies` |
| `catalog` | Catalog display name | 90 | any | `verified/identity-governance/entitlement-management/catalogs` |
| `conditional_access_policy` | Conditional Access policy display name | none | any | `verified/identity/conditional-access/policies` |
| `connected_organization` | Connected organization display name | none | any | `verified/identity-governance/entitlement-management/connected-organizations` |
| `custom_extension` | Entitlement management custom extension display name | none | any | `verified/identity-governance/entitlement-management/catalogs/custom-extensions` |
| `custom_task_extension` | Lifecycle workflows custom task extension display name | none | any | `verified/identityGovernance/lifecycleWorkflows/customTaskExtensions` |
| `group` | Group display name | 256 | any | `verified/groups` |
| `group_mail_nickname` | Group mail nickname | 64 | ASCII, without `@ ( ) \ [ ] " ; : < > ,` or a space | `verified/groups` |
| `lifecycle_workflow` | Lifecycle workflow display name | none | any | `verified/identityGovernance/lifecycleWorkflows/workflows` |
| `named_location` | Named location display name | none | any | `verified/identity/conditional-access/named-locations` |
| `role_definition` | Custom directory role display name | none | any | `verified/roleManagement/directory/roleDefinitions` |
| `terms_of_use_agreement` | Terms of Use agreement display name | none | any | `verified/identityGovernance/termsOfUse/agreements` |
| `user` | User display name | 256 | any | `verified/users` |
| `user_mail_nickname` | User mail nickname | 64 | any | [user resource type](https://learn.microsoft.com/en-us/graph/api/resources/user#properties) |

Descriptions have no kind: check them with `constraints` where your convention needs it.

### Token rules

`token_rules` checks the parts of a convention before they are rendered, on the values as
set in `tokens` (before any filter):

```hcl
token_rules = {
  organization = { required = true }
  environment  = { required = true, allowed_values = ["d", "q", "p"] }
  region       = { allowed_values = ["weu", "neu"] }
  instance     = { pattern = "^[0-9]{3}$" }
}
```

`required` fails the plan when the token is not set or empty. `allowed_values` and `pattern`
check a non-empty value only, so an optional part can stay empty. A rule applies whether or
not a template uses the token.

### Conditional Access policy names

Microsoft Learn recommends names that carry a sequence number, the cloud apps, the response
and the users, and that emergency (contingency) policies start with `ENABLE IN EMERGENCY`
([Plan a Conditional Access deployment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/plan-conditional-access#set-naming-standards-for-your-policies)).
An optional segment adds the prefix only when its token is set:

```hcl
templates = {
  block_legacy_auth = "[{emergency} - ]CA{sequence}-{apps}-{response}-{users}"
}
tokens = {
  emergency = "" # "ENABLE IN EMERGENCY" for the contingency copy
  sequence  = "001"
  apps      = "AllApps"
  response  = "BlockLegacyAuth"
  users     = "AllUsers"
}
# names = { block_legacy_auth = "CA001-AllApps-BlockLegacyAuth-AllUsers" }
```

## Enforcing a convention

The module checks the names that pass through it. A configuration can still give a module a
literal name, so the module makes the compliant path the easy one rather than the only one:

- Every verified module with a `display_name` input takes an optional `name_pattern` and
  fails the plan when its display name does not match; the groups and users modules also
  take `mail_nickname_pattern`. Pass them the `patterns` of the convention, as the usage
  example does: the module that creates the object then rejects a name that does not follow
  the convention, wherever the name came from. A hand-written pattern can be stricter where
  the convention leaves a token open, such as `^(ENABLE IN EMERGENCY - )?CA[0-9]{3}-` for
  the sequence number of the Conditional Access example.
- A policy-as-code check in the pipeline that runs Terraform, for example Conftest or Open
  Policy Agent on the JSON of `terraform show -json`, catches names that bypass both. It
  belongs to that pipeline, not to these modules.

### Derived patterns

`patterns` returns, per template, an RE2 expression anchored at both ends that every name
the template can render matches. It describes the convention rather than the current token
values, so the name of another partner, region or environment matches the same pattern. The
patterns depend on `templates`, `token_rules` and `transliterations` only, so they are known
during the plan even when a token value is not.

| Template | Pattern |
| --- | --- |
| `Partners/{organization}` | `(?s)^Partners/.+$` |
| `{organization\|ascii\|alnum}-guests` | `^[A-Za-z0-9]+-guests$` |
| `{organization\|ascii\|slug}-guests` | `^[a-z0-9]+(?:-[a-z0-9]+)*-guests$` |
| `kv-{company\|lower}-{region}[-{workload}]-{instance}`, with `allowed_values` `weu` and `neu` for `region` | `(?s)^kv-[^A-Z]+-(?:weu\|neu)(?:-.+)?-.+$` |

The parts of a template become:

- **Literal text and the built-in tokens:** the text, with the characters that RE2 reads as
  syntax escaped, so `a.b` becomes `a\.b`.
- **An optional segment:** an optional group, `(?:...)?`.
- **A placeholder whose token has `allowed_values`:** one of those values after the
  placeholder's filters, so `{environment|upper}` with `["d", "p"]` becomes `(?:D|P)`. A value
  that renders empty is left out; when none is left, `[^\x00-\x{10FFFF}]` matches nothing.
- **Any other placeholder:** a run of the characters that its filters leave.
  - After `slug`: words of letters and digits joined by single hyphens,
    `[\p{L}\p{N}]+(?:-[\p{L}\p{N}]+)*`.
  - After `alnum`: `[\p{L}\p{N}]+`.
  - After `ascii`, these narrow to `A-Za-z0-9`, or to `a-z0-9` after `lower` or `slug` and
    `A-Z0-9` after `upper`. `ascii` after `slug` keeps letters, digits and hyphens,
    `[a-z0-9-]+`, because dropping a word of another script can leave two hyphens together.
  - Otherwise a negated class of what `nospace` (`\s\p{Z}`), `lower` (`A-Z`), `upper`
    (`a-z`) and `ascii` (`\x{80}-\x{10FFFF}`) removed, such as `[^A-Z]+`, or `.+` when no
    filter removed anything. The pattern then starts with `(?s)`, so that `.` also matches a
    line break. `trim` adds nothing.

`ascii` keeps what an earlier filter guaranteed only when the transliteration table cannot
break it. The built-in table maps letters to letters of the same case, but `transliterations`
can map a letter to a space, to punctuation or to the other case; the pattern then widens to
what `ascii` alone guarantees. The built-in table spells `ß` as `ss` although `upper` leaves
`ß` unchanged, so `ascii` after `upper` does not keep the upper case.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |

No provider. Terraform 1.5 is the first version with the `strcontains` function that a
validation uses, and the `kinds` validations refer to other values of the module, which
Terraform allows from 1.9. The module and its offline test suite need Terraform 1.11 or
later.

## Limits

- **Up to four filters per placeholder**, and no nested optional segments.
- **No escape sequences.** Insert `{ } [ ]` with the built-in tokens.
- **Characters are counted as Terraform counts them.** `max_length` uses Terraform's
  `length`, which counts user-perceived characters. Microsoft Graph documents limits in
  characters without saying how it counts characters outside the Basic Multilingual Plane,
  such as emoji. Keep names within such limits by a margin, or use `ascii`.
- **Values known after apply.** When a token value is known only after apply, the name is
  too, and the preconditions are checked during the apply instead of the plan.
- **Sensitive tokens are not supported.** The `names` output is not sensitive, so a sensitive
  token value fails the plan. Names are visible in plans and in the Microsoft Entra admin
  center; do not build them from secrets.
- **Changing a template renames objects.** Whether a different name updates an object in
  place or replaces it depends on the module that uses the name; check its README.
- **A pattern is as strict as the convention.** A placeholder without `allowed_values`
  matches any value that its filters can produce, and a token's `pattern` and `required`
  rules are not part of it. Lengths are not either: `kinds` and `constraints` check them.
  Without `ascii`, a pattern does not express the case of letters outside `A-Z`.
- **Kinds follow the verified modules.** A kind changes when the validation of its module
  changes, and a name that a stricter kind rejects then fails the plan.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed on 2026-09-18. No licensing feature rule applies to this module: it makes no Microsoft Graph request and creates no object.

Notes:

- The module renders names from templates inside Terraform. It declares no provider, no resource and no data source, so it calls no API and needs no tenant.
- The objects that a caller names with it keep their own licensing rules; see the README of the module that creates each object.
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| templates | One template per name, keyed by an identifier of your choice | `map(string)` | n/a | yes | no object change (validation or timing only) |
| tokens | The token values, keyed by token name; null or empty values render empty | `map(string)` | `{}` | no | no object change (validation or timing only) |
| token_rules | Per token, `required`, `allowed_values` and an RE2 `pattern` that its value must meet | `map(object)` | `{}` | no | no object change (validation or timing only) |
| constraints | Per template key, `max_length` and an RE2 `pattern` that the rendered name must meet | `map(object)` | `{}` | no | no object change (validation or timing only) |
| kinds | Per template key, the built-in kind of name it renders, whose limits the name must meet | `map(string)` | `{}` | no | no object change (validation or timing only) |
| transliterations | Single characters and their ASCII replacements, merged over the table of the `ascii` filter | `map(string)` | `{}` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| names | The rendered names, keyed like `templates`; its preconditions fail the plan on a missing token, a broken token rule, an empty required placeholder, an empty name or a broken constraint | yes |
| patterns | Per template key, an anchored RE2 expression that every name the template can render matches, for the `name_pattern` inputs of the verified modules | yes |

## Tests

`tests/naming.tftest.hcl` runs offline and needs Terraform 1.11 or later: `terraform init`
and `terraform test` in this folder. Every run is a plan, because the module has no
provider. The runs cover each filter and their order, the transliteration table and its
overrides, NFC normalization, optional segments, the built-in tokens, the token rules, the
Conditional Access example, every precondition of `names` and every validation, the limit
of every kind, and the derived patterns of every filter, optional segment, allowed values
and custom transliteration, each checked against the names it renders. A Python test
(`tests/test_naming.py`) checks the validation messages, that the filter list is the same
in the validation, the module and this README, the transliteration table, that every kind
matches the validation of its verified module and this README, and that the module stays
free of providers and resources.
