# identityGovernance/termsOfUse/agreements

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Manages one Microsoft Entra ID Governance **Terms of Use agreement** and its **localized PDF
files** (`identityGovernance/termsOfUse/agreements`, v1.0) through the `microsoft/msgraph`
Terraform provider. An agreement is tenant configuration: the module **enforces nothing**. A
user is asked to accept it only when a Conditional Access policy requires it as a grant control,
which is a separate, explicit composition (see [Enforcing the agreement](#enforcing-the-agreement)).

The same objects are also reachable at `/agreements`. Only the `identityGovernance/termsOfUse`
path has documented operations, so this module is the single Terraform owner of an agreement; do
not manage the same agreement through the generated `/agreements` alias module.

**Acceptances are not managed.** An acceptance is a user's recorded consent, which is compliance
evidence, not configuration. The module never creates, approves or deletes an acceptance, and it
does not read acceptances either, because they hold user identifiers that would end up in the
Terraform state. Read them with the owner-dispatched probe in the
[acceptance runbook](#live-acceptance-runbook).

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "guest_terms" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/termsOfUse/agreements"
  version = "<version>"

  displayName                       = "Guest terms of use"
  isViewingBeforeAcceptanceRequired = true

  # The default file is created together with the agreement and fixed from then on.
  default_file = {
    language       = "en"
    fileName      = "guest-terms.pdf"
    displayName   = "Guest terms of use"
    content_base64 = filebase64("${path.module}/guest-terms-en.pdf")
  }

  # Further languages are added one by one; each is posted once.
  additional_files = {
    french = {
      language       = "fr-FR"
      fileName      = "guest-terms-fr.pdf"
      displayName   = "Conditions d'utilisation"
      content_base64 = filebase64("${path.module}/guest-terms-fr.pdf")
    }
  }
}

output "agreement_id" {
  value = module.guest_terms.id
}
```

### Enforcing the agreement

Creating the agreement changes nothing for any user. To require it, create a Conditional Access
policy with the
[policies module](../../../identity/conditionalAccess/policies/README.md) and pass the agreement
ID as a grant control. Leave the policy **report-only** (the module's default state,
`enabledForReportingButNotEnforced`) until the sign-in reports show who it would prompt, and
exclude the emergency access accounts as that module requires:

```hcl
module "guest_terms_policy" {
  source  = "satolap/modules/msgraph//verified/identity/conditionalAccess/policies"
  version = "<version>"

  displayName = "Guests accept the terms of use"
  # state defaults to enabledForReportingButNotEnforced; set "enabled" only after reviewing it.

  grant_controls = {
    terms_of_use = [module.guest_terms.id]
  }

  # users, applications and the emergency access exclusions as that module documents.
}
```

The reference orders the destroy so that the policy goes before the agreement (see
[Removing an agreement](#removing-an-agreement)). Coordinate with the Conditional Access work
before enabling a policy for real users: the module creates no policy and takes no decision about
who must accept.

## Behavior

- **Create.** `POST identityGovernance/termsOfUse/agreements` with `displayName`,
  `isViewingBeforeAcceptanceRequired` and a `files` array that holds the default file
  (`fileName`, `language`, `isDefault: true`, optional `displayName`, and the PDF as
  `fileData.data`). Learn's create *table* lists the file properties flat (`fileName`,
  `isDefault`, `language`, `data`) but its *example* sends the `files` array; the module follows
  the example. Neither form has been run against a tenant (GB-terms-of-use-504).
- **Localized files.** Every further language is added with Learn's *create
  agreementFileLocalization* call, `POST identityGovernance/termsOfUse/agreements/{id}/files`
  (`isDefault: false`), once, by a `msgraph_resource_action` that never sends again.
- **Language and default invariants.** Each file needs its own language, compared
  case-insensitively across `default_file` and `additional_files`. Exactly one file is the
  default: `default_file`, set when the agreement is created. Learn describes `isDefault` as
  read-only and documents no way to make another file the default, so a default change is a
  replacement of the agreement (see [Changing files](#changing-files)). Learn's rule that the
  first file is the default when none is marked is not relied on.
- **Language format.** `languagecode2-country/regioncode2` or a BCP-47 tag, for example `en`,
  `en-US` or `zh-Hant-TW`. The module checks the shape only, not that the language exists.
- **Content.** The PDF is an input as base64 text (`filebase64("file.pdf")`). The module checks
  that it is base64, that it starts with the PDF header (`%PDF-`) and that it decodes to at most
  2 MiB. The 2 MiB limit is this module's own and conservative: Learn states no size limit and it
  is **unverified against Graph's request limit** (the live runbook probes it); Graph may
  refuse a smaller or larger file. The module does not render, scan or validate the PDF beyond
  its header.
- **Read-back limits.** Graph's read of an agreement returns its properties but not the file
  content (the list of files shows `fileData` as null) and the files array is not part of the
  agreement read. Nothing therefore compares the PDF that Graph holds with the configured one,
  and a file added or removed in the portal is not detected. The `content_sha256` output is a
  SHA-256 of the configured base64 text, not of anything Graph returned.
- **Not managed.** `isPerDeviceAcceptanceRequired`, `termsExpiration` and
  `userReacceptRequiredFrequency` are on the resource page but in neither the create nor the
  update table, so the module does not send them (GB-terms-of-use-507). Set them in the portal
  if needed; the module neither detects nor resets them.
- **Terms of use is not enforcement.** See [Enforcing the agreement](#enforcing-the-agreement).

### Content in the Terraform state

The PDF is part of the request body, and the provider keeps the body in the Terraform state, so
the document is stored in the state file (as a sensitive value: a plan shows `(sensitive value)`
instead of the base64 text). Only the PDF leaf is marked, but Terraform may still show the whole
request `body` as sensitive, in which case a `displayName` change is not visible in the plan: read
it from the configuration diff. Treat the state as holding the agreement text. A terms of use
document is meant for every user who signs in, but if yours is not public, keep the state in a
backend that is access-controlled and encrypted. The module's outputs never carry the content:
`request_summary` and `content_sha256` carry names, languages, flags and a hash only. Do not
paste the document, or a state excerpt, into a public issue or evidence artifact.

## Changing files

Learn documents these calls for agreements and their files, and no others:

| Operation | Documented | What the module does |
| --- | --- | --- |
| Create agreement with files | yes | the first apply |
| Update agreement | `displayName` and `isViewingBeforeAcceptanceRequired` only | in place (PATCH); the ID never changes |
| Create localized file | yes | each `additional_files` entry, once |
| Update or delete a localized file, change the default file, create a new file version | **no** | refused at plan time |
| Delete agreement | yes | on destroy; see [Removing an agreement](#removing-an-agreement) |

So after an agreement exists:

- **Name and viewing requirement** change in place, with no effect on acceptances that Learn
  documents.
- **A new language** is added by a new `additional_files` key.
- **A change to a file that was already applied** (its PDF, name, language, display name or
  `isMajorVersion`, in `default_file` or in an `additional_files` entry) is **refused** by a
  plan-time check (`terraform_data.guard`), because Graph has no documented call for it and the
  provider would otherwise plan a request that Graph does not document or silently drop the
  change. The check compares the configuration with a record of what was applied
  (`terraform_data.default_file_applied` and `file_applied`).
- **Removing an `additional_files` key** only stops Terraform from tracking the file. The file
  **stays live in the agreement for users of that language**, because Learn documents no way to
  delete it: it can only be removed in the portal. Adding the same language again posts a second
  file for that language.
- **Replacing the agreement.** To publish a new document or default language, replace the
  agreement explicitly: `terraform apply -replace=module.guest_terms.msgraph_resource.agreement`
  with the new configuration. The agreement resource is created **before** the old one is
  destroyed (`create_before_destroy`), so the order is: the new agreement (new ID, no
  acceptances) is created and the additional files are posted to it; a Conditional Access policy
  that takes `module.guest_terms.id` is repointed to the new ID in the caller's configuration;
  and only then is the old agreement deleted. The records above are replaced with it, so the
  change check passes in that plan.
  - **Keep the policy referencing the module output** (`grant_controls.terms_of_use =
    [module.guest_terms.id]`) so that the repoint happens in the same apply, before the old
    agreement is deleted. If the policy holds a literal ID or lives in another state, migrate in
    two applies: create the new agreement (keep the old one, for example under a second module
    name), repoint the policy, check the report-only results, and delete the old module in a
    later apply. Never let an enforced policy point at an agreement that is about to be deleted:
    what Graph does then is not documented (see [Removing an agreement](#removing-an-agreement)).
  - **Every user has to accept the new agreement: it is renewed consent, not unchanged
    compliance.** The old agreement's acceptances are not carried over, and whether deleting the
    old agreement keeps or discards them is not documented.
  - Learn does not say that an agreement display name must be unique, so the old and the new
    agreement may exist with the same name for a moment. This is unverified; the live runbook
    probes it. If Graph refuses the create, change `displayName` in an earlier apply.

`isMajorVersion` is Learn's flag for a file update: a major version update invalidates the
agreement's acceptances for that language. The module can only send it with a *new* language
file, where it has no earlier acceptance to invalidate; it cannot re-version an existing file.

## Removing an agreement

`terraform destroy` (or removing the module) sends `DELETE identityGovernance/termsOfUse/agreements/{id}`,
which Learn documents with a 204 response. The additional-file actions are forgotten without a
request. Decisions, and what is not known:

- **Order.** Pass `module.<name>.id` to the Conditional Access policies module, as above. Terraform
  then destroys the policy before the agreement. If you **remove the policy's reference and the
  agreement in the same apply**, the reference no longer orders anything and the two may run in
  parallel: remove the grant control (or the policy) in one apply, check it, and remove the
  agreement in a second apply.
- **Delete while referenced.** Learn's delete page says nothing about an agreement that a
  Conditional Access policy still requires. Whether Graph refuses the delete, deletes it and
  leaves the policy with a dangling reference, or makes the policy unsatisfiable is **not
  documented and not tested**. Treat it as possibly leaving users blocked: a policy that requires
  a deleted agreement may stop sign-ins. Keep policies report-only until the live probe in the
  [acceptance runbook](#live-acceptance-runbook) has recorded the behavior.
- **Acceptances.** Whether deleting an agreement keeps, hides or discards the users' acceptance
  records is not documented. Treat deletion as the end of that agreement's compliance evidence:
  export what you need first, with the read-only probe.
- **No recovery.** Learn documents no restore or soft delete for agreements. The module does not
  hold the old document either, so keep the source PDF in version control.
- **Failure mode.** A refused delete fails the apply and leaves the agreement in the state.
  Read the error, remove the references, and run the destroy again.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.5.0 |

**Application permissions are not supported.** Every Terms of Use operation that the module uses
is documented for delegated access with a work or school account only; Learn lists "Not
supported" for application permissions and for personal Microsoft accounts. Run this module with a
delegated token of a signed-in administrator (for example the Azure CLI or interactive
provider authentication), not with a client secret or federated application credential, which
Graph is documented not to accept.

- Create, update and delete an agreement, and add a file: delegated `Agreement.ReadWrite.All`
  (least privileged; no higher privileged permission is listed).
- Get or list agreements, and list files: delegated `Agreement.Read.All`.
- The signed-in user needs a supported Microsoft Entra role: **Conditional Access Administrator**
  (least privileged) or **Security Administrator**.
- Reading acceptances (not done by the module) is `AgreementAcceptance.Read` or
  `AgreementAcceptance.Read.All`, also delegated only.
- Supported clouds: Learn marks the Terms of Use pages as available in all national clouds.

## Licence check (opt-in)

`licence_check` is `false` by default. Then the module reads nothing extra and needs no
extra permission. Set it to `true` to make the plan fail early when the tenant has no
usable Microsoft Entra ID P1 subscription (a P2 subscription also lists the P1 service
plan). The shared [licence guard](../../../security-baseline/licence-guard/README.md) reads `GET /subscribedSkus` and fails the plan
unless a subscribed SKU in the `Enabled` state with enabled prepaid units lists the
registry's P1 service plan. The plan IDs come from the licensing registry, not from this
module. The error names the SKUs that list the plan but do not qualify.

- Permission, only while the check is on: `Organization.Read.All` or
  `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).
- The check compares tenant subscriptions and their enabled units. It does not count
  per-user assignments or consumed units, and it is not a licence-compliance assessment.
- No resource depends on licence data, so the check can fail a plan but never adds or
  removes resources. The check is a precondition of the `licence_guard` module output, which
  the `licence_tier` output re-exports, so every plan evaluates it.
- Turn it off again to apply after a licence lapse, for example to delete objects.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | CONDITIONAL-ACCESS | Conditional Access requires Microsoft Entra ID P1. Risk-based policies (sign-in risk and user risk) also need Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, which is a separate rule. When the licenses expire, existing policies are not disabled or deleted; they can be viewed and deleted but no longer updated. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Users in scope of the policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |

Notes:

- Microsoft Learn's terms of use prerequisites require Microsoft Entra ID P1 licenses, and an agreement applies to users only when a Conditional Access policy requires it, so the Conditional Access rule (Microsoft Entra ID P1) is the one shown. A separate Terms of Use feature is deliberately not modelled: the cited pages state a tenant requirement but no counting rule (see issue 302), and tests/test_licensing.py keeps that collection unknown.
- The module manages tenant configuration only and enforces nothing; enforcement is the Conditional Access policies module. Administrators who create or modify terms of use need at least the Conditional Access Administrator role, and reading them at least Security Reader.
- Every Terms of Use operation that Microsoft Learn documents for agreements and their files is available to delegated work or school accounts only; application permissions are not supported, so no application identity can satisfy a licence or role requirement. See [Microsoft Entra terms of use: prerequisites](https://learn.microsoft.com/en-us/entra/identity/conditional-access/terms-of-use#prerequisites).
- The Terms of Use rules for this module were reviewed against Microsoft Learn on 2026-10-25, which is later than the review date stated above.
- The opt-in `licence_check` input (default false) fails the plan unless a usable Microsoft Entra ID P1 subscription exists; it reads GET /subscribedSkus only when true and then needs Organization.Read.All or LicenseAssignment.Read.All. It checks tenant subscriptions and enabled units, not per-user assignments.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| displayName | Display name of the agreement (internal; end users see the file display names); updated in place | `string` | n/a | yes | in place |
| default_file | The default localized PDF, created with the agreement: `language`, `fileName`, optional `displayName`, `content_base64`; fixed after creation | `object` | n/a | yes | kept from creation: a change is refused or ignored (see notes) |
| isViewingBeforeAcceptanceRequired | Whether a user has to expand the agreement before accepting; updated in place | `bool` | `false` | no | in place |
| additional_files | Further localized PDFs by key, each posted once; a key can be added, but a changed or removed entry is refused or forgotten | `map(object)` | `{}` | no | creates or deletes `msgraph_resource_action.file` instances; kept from creation: a change is refused or ignored (see notes) |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that displayName must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| licence_check | Opt-in plan-time check that a usable Microsoft Entra ID P1 subscription exists; reads `GET /subscribedSkus` only when `true` | `bool` | `false` | no | changes `module.licence_guard`; see the module notes |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The agreement ID, for `grant_controls.terms_of_use` of a Conditional Access policy | yes |
| display_name | The display name, as configured | yes |
| file_languages | Lower case, sorted languages of the managed files | yes |
| default_file_language | The default file's language, as configured | yes |
| additional_file_ids | The ID of each added file by key, as the create call returned it | no |
| content_sha256 | SHA-256 of each PDF's base64 text by language; a fingerprint of the input, not of what Graph holds | yes |
| request_summary | The create request without PDF content | yes |
| licence_tier | The licence tier that was checked: `p1` when `licence_check` is true, otherwise `free` | no |

## Live acceptance runbook

Nothing here has been run against a tenant: the module is offline-tested with a mock provider and
bound to the pinned Learn pages. The owner dispatches a live run; keep configuration testing
and acceptance testing apart.

**Configuration probe** (one administrator with a delegated token; no end user):

0. Size and name probes: apply once with a synthetic PDF near the 2 MiB limit and record Graph's answer (the limit is unverified), and during the replacement in step 5 record whether Graph accepts a second agreement with the same display name while the old one exists.
1. Apply the module with a synthetic one-page PDF. Check with Graph Explorer, as the same
   administrator, `GET identityGovernance/termsOfUse/agreements/{id}?$expand=files`: the default
   file is present with the configured language and `isDefault: true`. This is the first proof that
   the create call accepts the `files` array (GB-terms-of-use-504).
2. Change `displayName` and `isViewingBeforeAcceptanceRequired` and apply; the ID must stay
   the same and a refresh-only plan must be empty.
3. Add an `additional_files` entry; confirm the file appears and that a second apply posts nothing.
4. Remove that entry; confirm the file stays in the agreement and that a plan is empty.
5. Change the default file's content: the plan must fail at `terraform_data.guard`. Then run
   the `-replace` apply and record the new ID and that the old agreement was deleted only after the new one existed.
6. Import is not offered by the module; record whether the portal's agreements, created by hand,
   can be brought under management only by creating them again.

**Referenced-delete probe** (owner decision): create a report-only Conditional Access policy that
requires the agreement for a single test user, then delete the agreement through the module and
record Graph's answer and the policy's state afterwards. Never enable the policy for real users.

**Acceptance probe** (separate run, one dedicated test user, read-only for the module): have the
test user sign in and accept; read `GET identityGovernance/termsOfUse/agreements/{id}/acceptances`
with `AgreementAcceptance.Read.All` as the administrator and record the count and the state only.
Add a language file with `isMajorVersion = true` and a replacement agreement, and record whether
the user is asked again. Never create, approve or delete an acceptance, and keep the user
identifiers, names and the document out of public artifacts.

The acceptance probe above is automated by `.github/workflows/live-terms-of-use.yml` with a runner-cached test user; the owner setup is in `docs/terms-of-use-live-runner.md`.

Import of an existing agreement has not been verified.

## Related Graph behavior

`docs/graph-behavior/terms-of-use.md` records the Graph behavior this module relies on
(GB-terms-of-use-501 to 509), and `docs/graph-behavior/write-semantics.md` records the
change-guard pattern (GB-write-semantics-515).

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `displayName`: in place.
- `isViewingBeforeAcceptanceRequired`: in place.
- `default_file`: kept from creation: a change is refused or ignored (see notes).
- `additional_files`: creates or deletes `msgraph_resource_action.file` instances; kept from creation: a change is refused or ignored (see notes).
- `name_pattern`: no object change (validation or timing only).
- `licence_check`: changes `module.licence_guard`; see the module notes.
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /identityGovernance/termsOfUse/agreements` | DelegatedWork | `Agreement.ReadWrite.All` | - | - |
| `POST /identityGovernance/termsOfUse/agreements` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/termsOfUse/agreements` | Application | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/termsOfUse/agreements/{id}` | DelegatedWork | `Agreement.Read.All` | - | - |
| `GET /identityGovernance/termsOfUse/agreements/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/termsOfUse/agreements/{id}` | Application | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/termsOfUse/agreements/{id}` | DelegatedWork | `Agreement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/termsOfUse/agreements/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/termsOfUse/agreements/{id}` | Application | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/termsOfUse/agreements/{id}` | DelegatedWork | `Agreement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/termsOfUse/agreements/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/termsOfUse/agreements/{id}` | Application | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/termsOfUse/agreements/{id}/files` | DelegatedWork | `Agreement.ReadWrite.All` | - | - |
| `POST /identityGovernance/termsOfUse/agreements/{id}/files` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/termsOfUse/agreements/{id}/files` | Application | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /subscribedSkus` | DelegatedWork | `LicenseAssignment.Read.All` | - | - |
| `GET /subscribedSkus` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /subscribedSkus` | Application | `LicenseAssignment.Read.All` | - | - |

DevX uses equivalent route spellings for these requests (the inventory retains both):

- `POST /identityGovernance/termsOfUse/agreements/{id}/files` -> `/agreements/{id}/files`.

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /identityGovernance/termsOfUse/agreements` | `displayName`, `files`, `isViewingBeforeAcceptanceRequired` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /identityGovernance/termsOfUse/agreements/{id}` | `displayName`, `files`, `isViewingBeforeAcceptanceRequired` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /subscribedSkus` | `capabilityStatus`, `prepaidUnits`, `servicePlans`, `skuId`, `skuPartNumber` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
