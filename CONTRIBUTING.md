# Contributing to GraphModules

Thank you for helping improve GraphModules.

## Report a problem or request a module

Open a GitHub issue and include:

- the release tag and module path;
- your Terraform and `microsoft/msgraph` provider versions;
- a minimal configuration that reproduces the behavior;
- the expected and actual result; and
- sanitized logs or diagnostics, with tenant IDs, credentials, tokens, and
  personal data removed.

Use [SECURITY.md](SECURITY.md) instead for a suspected vulnerability.

## Propose a change

The generated and curated module trees are published from a separate source and
validation pipeline. Direct pull requests that edit `modules/generated/`,
`modules/curated/`, `.release/`, `NOTICE`, or release tags cannot be accepted
because the next validated publication replaces those files. Open an issue
describing the desired module change so it can be made and tested at the source.

Pull requests are welcome for this repository's public documentation and trusted
release tooling. Keep changes focused, explain their user impact, and update any
related documentation. Release-tool changes should preserve deterministic archives,
checksum verification, and the rule that tagged release content must be an ancestor
of `main`.

By contributing, you agree that your contribution is licensed under this
repository's [MIT License](LICENSE). Content derived from upstream Microsoft sources
also remains subject to the licenses identified in [NOTICE](NOTICE).

All contributors must follow the [Code of Conduct](CODE_OF_CONDUCT.md).
