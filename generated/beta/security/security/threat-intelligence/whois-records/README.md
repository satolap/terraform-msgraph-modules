# /security/threatIntelligence/whoisRecords

Create new navigation property to whoisRecords for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-whoisrecord?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/threatIntelligence/whoisRecords`, `GET/PATCH/DELETE /security/threatIntelligence/whoisRecords/{whoisRecord-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/threat-intelligence/whois-records"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `abuse` | `abuse` | `any` | no | no |
| `admin` | `admin` | `any` | no | no |
| `billing` | `billing` | `any` | no | no |
| `domain_status` | `domainStatus` | `string` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `first_seen_date_time` | `firstSeenDateTime` | `string` | no | no |
| `history` | `history` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.whoisHistoryRecord")       abuse = optional(any)       admin = optional(any)       billing = optional(any)       domainStatus = optional(string)       expirationDateTime = optional(string)       firstSeenDateTime = optional(string)       host = optional(object({       odata_type = optional(string, "#microsoft.graph.security.host")       childHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       components = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostComponent")       category = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)       version = optional(string)     })))       cookies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostCookie")       domain = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)     })))       firstSeenDateTime = optional(string)       hostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       lastSeenDateTime = optional(string)       parentHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       passiveDns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(any)       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       passiveDnsReverse = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(any)       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPort")       banners = optional(any)       firstSeenDateTime = optional(string)       host = optional(any)       lastScanDateTime = optional(string)       lastSeenDateTime = optional(string)       mostRecentSslCertificate = optional(any)       port = optional(number)       protocol = optional(any)       services = optional(any)       status = optional(any)       timesObserved = optional(number)     })))       reputation = optional(any)       sslCertificates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificate")       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       ports = optional(any)       sslCertificate = optional(any)     })))       subdomains = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.subdomain")       firstSeenDateTime = optional(string)       host = optional(any)     })))       trackers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostTracker")       firstSeenDateTime = optional(string)       host = optional(any)       kind = optional(string)       lastSeenDateTime = optional(string)       value = optional(string)     })))       whois = optional(any)     }))       lastSeenDateTime = optional(string)       lastUpdateDateTime = optional(string)       nameservers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.whoisNameserver")       firstSeenDateTime = optional(string)       host = optional(object({       odata_type = optional(string, "#microsoft.graph.security.host")       childHostPairs = optional(any)       components = optional(any)       cookies = optional(any)       firstSeenDateTime = optional(string)       hostPairs = optional(any)       lastSeenDateTime = optional(string)       parentHostPairs = optional(any)       passiveDns = optional(any)       passiveDnsReverse = optional(any)       ports = optional(any)       reputation = optional(any)       sslCertificates = optional(any)       subdomains = optional(any)       trackers = optional(any)       whois = optional(any)     }))       lastSeenDateTime = optional(string)     })))       noc = optional(any)       rawWhoisText = optional(string)       registrant = optional(any)       registrar = optional(any)       registrationDateTime = optional(string)       technical = optional(any)       whoisServer = optional(string)       zone = optional(any)     }))` | no | no |
| `host` | `host` | `object({       odata_type = optional(string, "#microsoft.graph.security.host")       childHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       components = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostComponent")       category = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)       version = optional(string)     })))       cookies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostCookie")       domain = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)     })))       firstSeenDateTime = optional(string)       hostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       lastSeenDateTime = optional(string)       parentHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       passiveDns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(object({       odata_type = optional(string, "#microsoft.graph.security.artifact")     }))       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       passiveDnsReverse = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(object({       odata_type = optional(string, "#microsoft.graph.security.artifact")     }))       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPort")       banners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortBanner")       banner = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       scanProtocol = optional(string)       timesObserved = optional(number)     })))       firstSeenDateTime = optional(string)       host = optional(any)       lastScanDateTime = optional(string)       lastSeenDateTime = optional(string)       mostRecentSslCertificate = optional(any)       port = optional(number)       protocol = optional(any)       services = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortComponent")       component = optional(any)       firstSeenDateTime = optional(string)       isRecent = optional(bool)       lastSeenDateTime = optional(string)     })))       status = optional(any)       timesObserved = optional(number)     })))       reputation = optional(any)       sslCertificates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificate")       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificatePort")       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       port = optional(number)     })))       sslCertificate = optional(any)     })))       subdomains = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.subdomain")       firstSeenDateTime = optional(string)       host = optional(any)     })))       trackers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostTracker")       firstSeenDateTime = optional(string)       host = optional(any)       kind = optional(string)       lastSeenDateTime = optional(string)       value = optional(string)     })))       whois = optional(any)     })` | no | no |
| `last_seen_date_time` | `lastSeenDateTime` | `string` | no | no |
| `last_update_date_time` | `lastUpdateDateTime` | `string` | no | no |
| `nameservers` | `nameservers` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.whoisNameserver")       firstSeenDateTime = optional(string)       host = optional(object({       odata_type = optional(string, "#microsoft.graph.security.host")       childHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       components = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostComponent")       category = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)       version = optional(string)     })))       cookies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostCookie")       domain = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)     })))       firstSeenDateTime = optional(string)       hostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       lastSeenDateTime = optional(string)       parentHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       passiveDns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(any)       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       passiveDnsReverse = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(any)       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPort")       banners = optional(any)       firstSeenDateTime = optional(string)       host = optional(any)       lastScanDateTime = optional(string)       lastSeenDateTime = optional(string)       mostRecentSslCertificate = optional(any)       port = optional(number)       protocol = optional(any)       services = optional(any)       status = optional(any)       timesObserved = optional(number)     })))       reputation = optional(any)       sslCertificates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificate")       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       ports = optional(any)       sslCertificate = optional(any)     })))       subdomains = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.subdomain")       firstSeenDateTime = optional(string)       host = optional(any)     })))       trackers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostTracker")       firstSeenDateTime = optional(string)       host = optional(any)       kind = optional(string)       lastSeenDateTime = optional(string)       value = optional(string)     })))       whois = optional(any)     }))       lastSeenDateTime = optional(string)     }))` | no | no |
| `noc` | `noc` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `raw_whois_text` | `rawWhoisText` | `string` | no | no |
| `registrant` | `registrant` | `any` | no | no |
| `registrar` | `registrar` | `any` | no | no |
| `registration_date_time` | `registrationDateTime` | `string` | no | no |
| `technical` | `technical` | `any` | no | no |
| `whois_server` | `whoisServer` | `string` | no | no |
| `zone` | `zone` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- abuse: polymorphic schema; accepts an untyped value
- admin: polymorphic schema; accepts an untyped value
- billing: polymorphic schema; accepts an untyped value
- history[].abuse: polymorphic schema; accepts an untyped value
- history[].admin: polymorphic schema; accepts an untyped value
- history[].billing: polymorphic schema; accepts an untyped value
- history[].host.childHostPairs[].childHost: recursive schema; accepts an untyped value
- history[].host.childHostPairs[].parentHost: recursive schema; accepts an untyped value
- history[].host.components[].host: recursive schema; accepts an untyped value
- history[].host.cookies[].host: recursive schema; accepts an untyped value
- history[].host.hostPairs[].childHost: recursive schema; accepts an untyped value
- history[].host.hostPairs[].parentHost: recursive schema; accepts an untyped value
- history[].host.parentHostPairs[].childHost: recursive schema; accepts an untyped value
- history[].host.parentHostPairs[].parentHost: recursive schema; accepts an untyped value
- history[].host.passiveDnsReverse[].artifact: nested schema exceeds depth limit; accepts an untyped value
- history[].host.passiveDnsReverse[].parentHost: recursive schema; accepts an untyped value
- history[].host.passiveDns[].artifact: nested schema exceeds depth limit; accepts an untyped value
- history[].host.passiveDns[].parentHost: recursive schema; accepts an untyped value
- history[].host.ports[].banners: nested schema exceeds depth limit; accepts an untyped value
- history[].host.ports[].host: recursive schema; accepts an untyped value
- history[].host.ports[].mostRecentSslCertificate: polymorphic schema; accepts an untyped value
- history[].host.ports[].protocol: polymorphic schema; accepts an untyped value
- history[].host.ports[].services: nested schema exceeds depth limit; accepts an untyped value
- history[].host.ports[].status: polymorphic schema; accepts an untyped value
- history[].host.reputation: polymorphic schema; accepts an untyped value
- history[].host.sslCertificates[].host: polymorphic schema; accepts an untyped value
- history[].host.sslCertificates[].ports: nested schema exceeds depth limit; accepts an untyped value
- history[].host.sslCertificates[].sslCertificate: polymorphic schema; accepts an untyped value
- history[].host.subdomains[].host: recursive schema; accepts an untyped value
- history[].host.trackers[].host: recursive schema; accepts an untyped value
- history[].host.whois: polymorphic schema; accepts an untyped value
- history[].nameservers[].host.childHostPairs: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.components: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.cookies: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.hostPairs: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.parentHostPairs: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.passiveDns: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.passiveDnsReverse: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.ports: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.reputation: polymorphic schema; accepts an untyped value
- history[].nameservers[].host.sslCertificates: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.subdomains: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.trackers: nested schema exceeds depth limit; accepts an untyped value
- history[].nameservers[].host.whois: polymorphic schema; accepts an untyped value
- history[].noc: polymorphic schema; accepts an untyped value
- history[].registrant: polymorphic schema; accepts an untyped value
- history[].registrar: polymorphic schema; accepts an untyped value
- history[].technical: polymorphic schema; accepts an untyped value
- history[].zone: polymorphic schema; accepts an untyped value
- host.childHostPairs[].childHost: recursive schema; accepts an untyped value
- host.childHostPairs[].parentHost: recursive schema; accepts an untyped value
- host.components[].host: recursive schema; accepts an untyped value
- host.cookies[].host: recursive schema; accepts an untyped value
- host.hostPairs[].childHost: recursive schema; accepts an untyped value
- host.hostPairs[].parentHost: recursive schema; accepts an untyped value
- host.parentHostPairs[].childHost: recursive schema; accepts an untyped value
- host.parentHostPairs[].parentHost: recursive schema; accepts an untyped value
- host.passiveDnsReverse[].parentHost: recursive schema; accepts an untyped value
- host.passiveDns[].parentHost: recursive schema; accepts an untyped value
- host.ports[].host: recursive schema; accepts an untyped value
- host.ports[].mostRecentSslCertificate: polymorphic schema; accepts an untyped value
- host.ports[].protocol: polymorphic schema; accepts an untyped value
- host.ports[].services[].component: polymorphic schema; accepts an untyped value
- host.ports[].status: polymorphic schema; accepts an untyped value
- host.reputation: polymorphic schema; accepts an untyped value
- host.sslCertificates[].host: polymorphic schema; accepts an untyped value
- host.sslCertificates[].sslCertificate: polymorphic schema; accepts an untyped value
- host.subdomains[].host: recursive schema; accepts an untyped value
- host.trackers[].host: recursive schema; accepts an untyped value
- host.whois: polymorphic schema; accepts an untyped value
- nameservers[].host.childHostPairs[].childHost: recursive schema; accepts an untyped value
- nameservers[].host.childHostPairs[].parentHost: recursive schema; accepts an untyped value
- nameservers[].host.components[].host: recursive schema; accepts an untyped value
- nameservers[].host.cookies[].host: recursive schema; accepts an untyped value
- nameservers[].host.hostPairs[].childHost: recursive schema; accepts an untyped value
- nameservers[].host.hostPairs[].parentHost: recursive schema; accepts an untyped value
- nameservers[].host.parentHostPairs[].childHost: recursive schema; accepts an untyped value
- nameservers[].host.parentHostPairs[].parentHost: recursive schema; accepts an untyped value
- nameservers[].host.passiveDnsReverse[].artifact: nested schema exceeds depth limit; accepts an untyped value
- nameservers[].host.passiveDnsReverse[].parentHost: recursive schema; accepts an untyped value
- nameservers[].host.passiveDns[].artifact: nested schema exceeds depth limit; accepts an untyped value
- nameservers[].host.passiveDns[].parentHost: recursive schema; accepts an untyped value
- nameservers[].host.ports[].banners: nested schema exceeds depth limit; accepts an untyped value
- nameservers[].host.ports[].host: recursive schema; accepts an untyped value
- nameservers[].host.ports[].mostRecentSslCertificate: polymorphic schema; accepts an untyped value
- nameservers[].host.ports[].protocol: polymorphic schema; accepts an untyped value
- nameservers[].host.ports[].services: nested schema exceeds depth limit; accepts an untyped value
- nameservers[].host.ports[].status: polymorphic schema; accepts an untyped value
- nameservers[].host.reputation: polymorphic schema; accepts an untyped value
- nameservers[].host.sslCertificates[].host: polymorphic schema; accepts an untyped value
- nameservers[].host.sslCertificates[].ports: nested schema exceeds depth limit; accepts an untyped value
- nameservers[].host.sslCertificates[].sslCertificate: polymorphic schema; accepts an untyped value
- nameservers[].host.subdomains[].host: recursive schema; accepts an untyped value
- nameservers[].host.trackers[].host: recursive schema; accepts an untyped value
- nameservers[].host.whois: polymorphic schema; accepts an untyped value
- noc: polymorphic schema; accepts an untyped value
- registrant: polymorphic schema; accepts an untyped value
- registrar: polymorphic schema; accepts an untyped value
- technical: polymorphic schema; accepts an untyped value
- zone: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
