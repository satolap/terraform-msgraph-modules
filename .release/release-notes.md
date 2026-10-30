Microsoft Graph modules for v1.0 and beta, plus verified modules.

Summary:

- v1.0: 311 modules; 0 added, 9 removed, 311 interface-changed.
- beta: 623 modules; 0 added, 10 removed, 623 interface-changed.
- verified: 43 modules; 1 added, 0 removed, 28 interface-changed.
- Accepted breaking changes: 990 in 979 modules, from 8 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Catalog custom extensions accept a launch and wait callback and reject it on assignment workflow extensions
  - Decision: `2026-10-07-custom-extension-launch-and-wait.json`, approved by agent review (two independent reviews).
  - Accepted changes by kind: precondition_changed: 1.
  - Accepted changes by catalog: verified: 1.
  - Migration notes: The catalog custom extension module (verified/identity-governance/entitlement-management/catalogs/custom-extensions) gains launch and wait. The new optional input callback defaults to null. Without it the request body is unchanged, so callers that do not set it see no plan change. callback = { timeout = "PT1H" } adds callbackConfiguration = { timeoutDuration = &lt;timeout&gt; } to the create and update body, and entitlement management then pauses each request at the stages the extension is bound to until the resume action is called on the request. timeout must be an ISO 8601 duration in whole days, hours and minutes, in normal form (at most 23 hours and 59 minutes, no zero part and no leading zero), from PT5M to P14D. The new resource precondition fails a plan when callback is set and extension_type is assignment_workflow, which Microsoft Learn says does not support launch and wait; it reads only the new input, so it cannot fail the plan of a caller that does not set callback. The unmanaged_properties check keeps its condition and message, but reports callbackConfiguration only while callback is null, because a configured callback is in the body and its drift shows in the plan. Setting callback back to null later updates the extension in place without the callback, and Microsoft Graph keeps the callback, so the extension stays launch and wait and the check warns after the apply; replace the extension, for example with terraform apply -replace='module.&lt;name&gt;.msgraph_resource.this', to return it to launch and continue. callback is not part of the replacement trigger. The new output launch_and_wait is true when callback is set. The callback body contains only timeoutDuration, without @odata.type.
- Bound the provider requirement of 30 verified modules above: msgraph below 0.7.0, null below 4.0.0 and time below 1.0.0.
  - Decision: `2026-10-27-provider-upper-bounds.json`, approved by the owner.
  - Accepted changes by kind: provider_requirement_changed: 29.
  - Accepted changes by catalog: verified: 29.
  - Migration notes: Each affected verified module keeps its minimum provider version and gains a ceiling that contains the approved execution pins (msgraph 0.6.0, null 3.3.2, time 0.14.2). A root that pins or locks msgraph 0.7.0 or later, null 4.0.0 or later or time 1.0.0 or later can no longer use these modules until a later release raises the window after testing. Roots on the approved pins are unaffected. The 30 findings are bound by key and detail digest.
- Remove 17 generated collections whose metadata PATCH contradicts the pinned Learn PUT contract.
  - Decision: `2026-10-27-put-only-updates.json`, approved by the owner.
  - Accepted changes by kind: module_removed: 17.
  - Accepted changes by catalog: v1.0: 8, beta: 9.
  - Migration notes: This draft removes 17 generated modules. The release asset interface-changes.json lists every removed module, and each catalog manifest.json lists the excluded collections under exclusions. Before upgrading, stop managing affected objects without deleting them: add a Terraform removed { from = module.&lt;name&gt; lifecycle { destroy = false } } block (Terraform 1.7 or later), or run terraform state rm module.&lt;name&gt;.msgraph_resource.this; then review the plan. If the old module block remains, terraform init fails on the new release. The verified v1.0 replacement for the custom workflow extension is modules/verified/identity-governance/entitlement-management/catalogs/custom-extensions; state handoff to it is unreviewed. Key-set users should manage keys outside Terraform because private key material would persist in Terraform state. The 17 findings are bound by key and detail digest; the owner approved this decision.
  - Beta preview: 9 accepted changes in beta modules, which are preview and may break in a minor release.
- Exclude generated named locations whose required delete state cannot be enforced
  - Decision: `2026-10-28-delete-contracts.json`, approved by agent review (two independent reviews).
  - Accepted changes by kind: module_removed: 2.
  - Accepted changes by catalog: v1.0: 1, beta: 1.
  - Migration notes: This release removes the generated v1.0 and beta modules sourced from //v1.0/identity/conditional-access/named-locations and //beta/identity/conditional-access/named-locations. Terraform rejects a `removed` block while a module call of the same name is still declared, so make one change on your current v4.x module ref, before you bump the source: replace each module block with `removed { from = module.&lt;name&gt; lifecycle { destroy = false } }` and apply. Terraform 1.11 or later is required (the verified modules declare `required_version = "&gt;= 1.11.0"`). Alternatively, back up the state and run `terraform state rm module.&lt;name&gt;`. Only after state no longer tracks the objects should you bump the source ref. If you delete a module block while its objects remain in state, Terraform plans a real DELETE of the named locations; a trusted IP location then fails closed with Error 1177 (no data loss), and an untrusted location is deleted. To manage the existing objects again, use the verified named-locations/ip-ranges module for IP locations (odata_type #microsoft.graph.ipNamedLocation) and the verified named-locations/countries module for country locations (#microsoft.graph.countryNamedLocation). Map the old inputs: displayName to display_name; for IP locations isTrusted to is_trusted and the cidrAddress of each ipRanges entry to the ip_ranges set of canonical CIDR strings; for country locations countriesAndRegions to countries_and_regions, includeUnknownCountriesAndRegions to include_unknown_countries_and_regions and countryLookupMethod to country_lookup_method. The old odata_type input is implied by the choice of module, and keys passed in additional_properties map to these inputs; a key with no verified input cannot be carried over. Import each object into the verified module's `msgraph_resource.named_location`: `terraform import 'module.&lt;new&gt;.msgraph_resource.named_location' /identity/conditionalAccess/namedLocations/&lt;location-id&gt;` (or an `import` block with the same `to` address and `id`). The ID is the Graph resource path of the object; the verified modules accept only api_version v1.0, so a former beta module's object is imported the same way. Run `terraform plan` before you apply and require that `msgraph_resource.named_location` is neither updated nor replaced; an update or replacement means an input does not match the live object. The plan still creates the module's own helper resources, which are absent from your state: `terraform_data.country_lookup_method` in the countries module, and in the ip-ranges module `terraform_data.trust` and `msgraph_resource_action.trust`, which sends one idempotent PATCH that re-sends the configured isTrusted value. Review that `is_trusted` equals the live value so the PATCH changes nothing. Untrusting a trusted IP location changes every Conditional Access policy that includes or excludes `AllTrusted`: Terraform sees no dependency, and once is_trusted is false such a policy stops treating the network as trusted (for example, an "all locations except AllTrusted: block" policy blocks sign-ins from that network, including yours, and "MFA except trusted" policies start prompting). For a trusted IP location, set is_trusted = true on the verified ip-ranges module before importing: it defaults to false, and because the module ignores isTrusted drift on the location itself, leaving it unset shows no change on the location in the plan yet the first apply untrusts it. Before untrusting, list the enabled policies and filter on the client for `AllTrusted` in conditions.locations, then create and trust a replacement location first or reference this location's id explicitly (see modules/verified/identity/conditional-access/named-locations/ip-ranges/README.md, Limits and lifecycle). A trusted IP location still requires a separate untrust PATCH and an independent GET confirming isTrusted=false before deletion; Error 1177 must not be blindly retried. This conservative exclusion covers the polymorphic collection, including untrusted IP and country locations. Comparison: generation from the repository's sources.lock.json (metadata commit 1fd0ef510f79f3dadb3e083bdebc9496f939a11c, documentation commit 4b7867afe88f98d2415ac2f0219debe86fcb5652) together with this branch's verified modules, compared with the published v4.0.0 release using scripts/diff_release.py --defer-runtime-evidence (runtime evidence findings are not compared), reports exactly these two module removals as the only blocking findings; all other findings are accepted by existing decisions.
  - Beta preview: 1 accepted change in beta modules, which are preview and may break in a minor release.
- Add explicit DirectoryRole preview catalog onboarding without enabling package role grants
  - Decision: `2026-10-28-directory-role-catalog-onboarding.json`, approved by the owner.
  - Accepted changes by kind: validation_changed: 1.
  - Accepted changes by catalog: verified: 1.
  - Migration notes: Existing AadGroup, AadApplication, SharePointOnline and AzureResources callers keep their request bodies, replacement identity and cleanup state unchanged. DirectoryRole is newly accepted only with acknowledge_directory_role_preview = true and a GUID resource_origin_id naming the Entra role definition. The GUID validation is conditional and does not restrict existing origins. The acknowledgement defaults to false and is excluded from replacement identity; it is required for every DirectoryRole plan and apply. Onboarding requires a separately authorized privileged caller and Governance or Suite licensing. This only adds a catalog resource. Onboarding lets catalog owners and access package managers include this role in access packages; onboard only roles you would delegate to them, and avoid privileged roles. The resource-role-scopes module still rejects DirectoryRole and no downstream grant or live acceptance is claimed. This inactive draft binds the origin/main-to-candidate interface comparison, not a publication approval. Re-run the gate against the actual published catalog and rebind the finding if its detail differs before approving publication.
- Exclude the untested msgraph 0.7 minor line from newly generated modules.
  - Decision: `2026-10-28-generated-provider-window.json`, approved by the owner.
  - Accepted changes by kind: provider_requirement_changed: 934.
  - Accepted changes by catalog: v1.0: 311, beta: 623.
  - Migration notes: Generated modules add an msgraph ceiling below 0.7.0; the 0.4.0 floor is unchanged. Module inputs, outputs and state schema are unchanged. With a root lock selecting msgraph 0.7.0 or later, terraform init fails. terraform init -upgrade can select 0.6.0 when root constraints allow it; it also fails to resolve when the root requires 0.7.0 or later. Callers cannot override a child module's required_providers. Pin the previous module release, or review provider and state downgrade compatibility before choosing msgraph 0.6.0 and committing the resulting root lock. Roots already locked to 0.6.0 need no state migration for this ceiling change.
  - Beta preview: 623 accepted changes in beta modules, which are preview and may break in a minor release.
- Confirm IP named-location trust changes with a typed PATCH and independent bounded GET
  - Decision: `2026-10-28-ip-named-location-trust-confirmation.json`, approved by agent review (two independent reviews).
  - Accepted changes by kind: postcondition_changed: 1, precondition_changed: 1, provider_requirement_changed: 1, replacement_changed: 1.
  - Accepted changes by catalog: verified: 4.
  - Migration notes: Draft only; not publication approval. The IP named-location module now requires microsoft/msgraph &gt;= 0.6.0, &lt; 0.7.0 for its native trust action. Roots whose lock file pins msgraph 0.5.x must run `terraform init -upgrade` before planning. Existing callers must then run one unchanged apply. It registers the new separate trust PATCH (msgraph_resource_action.trust) against the saved location ID without replacing the location; tests/upgrade.tftest.hcl proves this from v4.0.0-shaped state offline. WARNING: that first upgraded apply sends a PATCH with the configured is_trusted, so it overwrites any out-of-band trust change and takes effect immediately for every Conditional Access policy that includes or excludes AllTrusted. Callers must review that plan and those policies before applying. BEHAVIOUR CHANGE: v4.0.0 corrected out-of-band trust drift in place. Now msgraph_resource.named_location ignores body.isTrusted and the trust action ignores all changes, so refresh proposes no correction. The independent GET (data.msgraph_resource.verify_trust) is read on every plan, not only on apply: when live trust differs from is_trusted, every plan polls for up to two minutes and then fails its postcondition, and nothing corrects the value. Recover with a reviewed apply that replaces only the trust action: terraform apply -replace='module.&lt;name&gt;.msgraph_resource_action.trust', where &lt;name&gt; is the module call label; this resends the typed PATCH, so check enabled AllTrusted policies first. Trust changes replace only the PATCH action registration; its destroy performs no HTTP request. Name/range changes finish before that trust PATCH. The independent GET polls a stale trust boolean or a replication 404 for the new ID (anchored not-found patterns, GET only) for at most two minutes; an identity, type or trust mismatch fails the plan or apply that reads it. An unchanged apply retries verification without replaying a completed PATCH. Before destroy or removing configuration, check enabled AllTrusted policies, set is_trusted=false, and complete a separate successful apply. Terraform destroy does not evaluate these postconditions or automatically prepare untrust; direct destroy of a trusted location still fails with Graph error 1177. Preserve state and run ownership evidence for failed preparation and stranded-object recovery. Never interpret a successful PATCH, a 403 or a timeout as untrust/absence proof. The original CRUD resource still owns DELETE. Rebound against the published v4.0.0 catalog: the full release gate reports four ip-ranges findings from this change, namely a provider requirement change to microsoft/msgraph &gt;= 0.6.0, &lt; 0.7.0 (already bound to the earlier upper-bound-only requirement by the provider upper bounds decision, so it blocks until this draft's digest is active), one added lifecycle precondition, one added replace_triggered_by trigger and one added postcondition. The Terraform floor finding no longer applies because v4.0.0 already requires it. This draft binds exactly those four findings and no others. Live provider request bodies, convergence, repeated cleanup and exact-ID 404 after teardown remain unverified. Independent review and a current full publication comparison are required before activating a release decision.
- Add the exact scoped-role-member replication-message guard
  - Decision: `2026-10-28-scoped-role-member-replication.json`, approved by agent review (two independent reviews).
  - Accepted changes by kind: precondition_changed: 2.
  - Accepted changes by catalog: v1.0: 1, beta: 1.
  - Migration notes: Generated v1.0 and beta administrative-unit scoped-role-member modules now reject request values that contain the exact reviewed source-resource error sentence (The source resource object or one of the objects being referenced don't exist). Remove that sentence from request values before upgrading. When roleMemberInfo is set, the module also sets the provider retry to an expression that matches only a Graph error envelope whose code is BadRequest or Request_BadRequest and whose message is exactly that sentence followed by a period (the apostrophe may be plain or JSON-escaped), bounded by the existing create and update timeouts, so a genuinely invalid reference can fail only when the timeout runs out. It does not match any other error code (404 included), an extended message, or the sentence outside the error envelope. The message is documented by Microsoft Learn for adding a member to a group, not for scopedRoleMembers, and Graph's response for this endpoint is not confirmed by a live run (reviewed-unverified), so the retry may never trigger. No other module, input or output changes, and no $ref lifecycle or 404 matcher is introduced.
  - Beta preview: 1 accepted change in beta modules, which are preview and may break in a minor release.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Verified modules:

- Added: `modules/verified/compositions/connected-organization-access`.
- Interface-changed:
  - `modules/verified/applications`: provider_requirement_changed: 1.
  - `modules/verified/applications/passwordCredentials`: provider_requirement_changed: 1.
  - `modules/verified/directory/administrative-units`: provider_requirement_changed: 1.
  - `modules/verified/groups`: provider_requirement_changed: 1.
  - `modules/verified/groups/members`: provider_requirement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/access-packages`: provider_requirement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/access-packages/resource-role-scopes`: provider_requirement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/assignment-policies`: provider_requirement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs`: provider_requirement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs/custom-extensions`: output_added: 1, precondition_changed: 1, provider_requirement_changed: 1, variable_added: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs/resources`: provider_requirement_changed: 2, validation_changed: 1, validation_relaxed: 1, variable_added: 1.
  - `modules/verified/identity-governance/entitlement-management/connected-organizations`: provider_requirement_changed: 1.
  - `modules/verified/identity/conditional-access/named-locations/countries`: provider_requirement_changed: 1.
  - `modules/verified/identity/conditional-access/named-locations/ip-ranges`: postcondition_changed: 1, precondition_changed: 1, provider_requirement_changed: 1, replacement_changed: 1.
  - `modules/verified/identity/conditional-access/policies`: output_added: 1, provider_requirement_changed: 1, variable_added: 1.
  - `modules/verified/identityGovernance/entitlementManagement/assignments`: provider_requirement_changed: 3.
  - `modules/verified/identityGovernance/lifecycleWorkflows/customTaskExtensions`: provider_requirement_changed: 1.
  - `modules/verified/identityGovernance/lifecycleWorkflows/workflows`: provider_requirement_changed: 1.
  - `modules/verified/identityGovernance/privilegedAccess/group/assignmentScheduleRequests`: provider_requirement_changed: 1.
  - `modules/verified/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`: provider_requirement_changed: 1.
  - `modules/verified/identityGovernance/termsOfUse/agreements`: output_added: 1, provider_requirement_changed: 1, variable_added: 1.
  - `modules/verified/policies/authenticationStrengthPolicies`: output_added: 1, variable_added: 1.
  - `modules/verified/role-management/directory/role-schedules`: provider_requirement_changed: 2.
  - `modules/verified/role-management/entitlement-management/role-assignments`: provider_requirement_changed: 1.
  - `modules/verified/security-baseline/licence-guard`: provider_requirement_relaxed: 1.
  - `modules/verified/service-principals`: provider_requirement_changed: 1.
  - `modules/verified/servicePrincipals/passwordCredentials`: provider_requirement_changed: 1.
  - `modules/verified/users`: provider_requirement_changed: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `0cc91229d28e04b984d94410a74fad4427c97e7e`
- Microsoft Graph metadata commit: `1fd0ef510f79f3dadb3e083bdebc9496f939a11c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `9274690b81e31aed08903a6b74f62f0713541c2e308b9f57cad5fade9311afae`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 311/311, contract_reviewed 6/311, lifecycle_verified 0/311
- beta: schema_validated 623/623, contract_reviewed 6/623, lifecycle_verified 0/623

Contract/interface and evidence changes found by the release gate against `v4.0.0`:

- module_added: 1 module added to the catalog (notice).
- module_removed: 19 modules removed from the catalog (blocking).
- output_added: 4 outputs added (notice).
- postcondition_changed: 1 module whose resource or data source postconditions were added or changed (blocking).
- precondition_changed: 4 modules whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- provider_requirement_changed: 964 provider requirements whose local binding, source, aliases or version constraint changed without proof that every previously accepted version remains supported (blocking).
- provider_requirement_relaxed: 1 provider requirement whose version constraint provably still accepts every previously accepted stable version (notice).
- replacement_changed: 1 module whose replace_triggered_by triggers, the terraform_data values they reference, or their transitive local expressions changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- validation_changed: 1 input with a new or changed validation that may reject values accepted before (blocking).
- validation_relaxed: 1 input whose validation changed but provably still accepts every value accepted before (notice).
- variable_added: 5 inputs added with a default, so existing configurations still plan (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "5.0.0"`.
