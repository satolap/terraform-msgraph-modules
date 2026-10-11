# naming

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
- **Mistakes fail the plan.** A token that is not set or breaks its rule, a required
  placeholder that renders empty, an empty name, or a name that breaks its `constraints`
  fails the plan with a message that names the token or the template.
- **The convention is the caller's.** The module ships no convention. Segments, separators
  and codes are a governance decision that belongs in the calling configuration.
- **Names are not checked against a tenant.** The module does not know whether a name is
  already taken. The module that creates the object, or Microsoft Graph, decides that.

## Usage

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-github) explains how to choose one.

```hcl
module "partner_names" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/naming?ref=<release-tag>"

  templates = {
    catalog         = "Partners/{organization}"
    access_package  = "{organization} guest access"
    guests_group    = "{organization|ascii|alnum}-guests"
    guests_nickname = "{organization|ascii|slug}-guests"
  }

  tokens = {
    organization = "Fabrikam Café"
  }

  constraints = {
    catalog         = { max_length = 90 }
    guests_nickname = { max_length = 64, pattern = "^[a-z0-9-]+$" }
  }
}

module "guests_group" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/groups?ref=<release-tag>"

  display_name  = module.partner_names.names.guests_group    # FabrikamCafe-guests
  mail_nickname = module.partner_names.names.guests_nickname # fabrikam-cafe-guests
}
```

### An Azure-style convention

Optional segments reproduce conventions that join components with a separator and leave
out the empty ones:

```hcl
module "azure_names" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/naming?ref=<release-tag>"

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
The module knows no object's limits by itself: set the limits of the object each name is
for, as its curated module or Microsoft Learn documents them.

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

- A curated module with a `name_pattern` input, such as the catalog custom extension module,
  fails the plan when its display name does not match. Pass the same pattern there.
- A policy-as-code check in the pipeline that runs Terraform, for example Conftest or Open
  Policy Agent on the JSON of `terraform show -json`, catches names that bypass both. It
  belongs to that pipeline, not to these modules.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |

No provider. Terraform 1.5 is the first version with the `strcontains` function that a
validation uses. The offline test suite needs Terraform 1.7 or later.

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

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed on 2026-09-18. No licensing feature rule applies to this module: it makes no Microsoft Graph request and creates no object.

Notes:

- The module renders names from templates inside Terraform. It declares no provider, no resource and no data source, so it calls no API and needs no tenant.
- The objects that a caller names with it keep their own licensing rules; see the README of the module that creates each object.
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| templates | One template per name, keyed by an identifier of your choice | `map(string)` | n/a | yes |
| tokens | The token values, keyed by token name; null or empty values render empty | `map(string)` | `{}` | no |
| token_rules | Per token, `required`, `allowed_values` and an RE2 `pattern` that its value must meet | `map(object)` | `{}` | no |
| constraints | Per template key, `max_length` and an RE2 `pattern` that the rendered name must meet | `map(object)` | `{}` | no |
| transliterations | Single characters and their ASCII replacements, merged over the table of the `ascii` filter | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| names | The rendered names, keyed like `templates`; its preconditions fail the plan on a missing token, a broken token rule, an empty required placeholder, an empty name or a broken constraint |

## Tests

`tests/naming.tftest.hcl` runs offline and needs Terraform 1.7 or later: `terraform init`
and `terraform test` in this folder. Every run is a plan, because the module has no
provider. The runs cover each filter and their order, the transliteration table and its
overrides, NFC normalization, optional segments, the built-in tokens, the token rules, the
Conditional Access example, every precondition of `names` and every validation. A Python test (`tests/test_naming.py`) checks the validation
messages, that the filter list is the same in the validation, the module and this README,
the transliteration table, and that the module stays free of providers and resources.
