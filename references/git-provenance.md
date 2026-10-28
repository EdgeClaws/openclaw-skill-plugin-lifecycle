# Git Provenance for Skills and Plugins

Every repository-owned skill or plugin change needs a commit that explains what
changed and why the actor was authorized. Direct Workshop `auto` maintenance
also needs one. Workshop proposal/apply changes use Workshop's immutable
revision, event, provenance, and rollback records instead.

## Before editing

1. Resolve the repository root with `git rev-parse --show-toplevel`.
2. Inspect `repository-publication.json`, status, and unrelated changes.
3. Resolve the requester through `authoring-ownership.json`; record the owner
   or exact grant that permits the change.
4. If no repository owns the artifact, initialize one at the narrowest stable
   owning root. Do not use a broad home, workspace parent, or state directory.
5. Record the origin: requester principal or autonomous source session/run.

## Commit content

Stage only the artifact and governing references changed for this request.
Review the staged diff before committing.

Use an ordinary subject plus provenance trailers:

```text
skill(openclaw-skill-plugin-lifecycle): define authoring jurisdiction

Initiated-By: Jared Pearson
Change-Origin: owner-request
Source-Context: telegram message 17236
```

For delegated work, also include the owner behind the grant:

```text
Initiated-By: RJ Ricasata
Authorized-By: Jared Pearson
Change-Origin: delegated-maintainer
Source-Context: slack message 17236
```

Allowed `Change-Origin` values:

- `owner-request`
- `delegated-maintainer`
- `teammate-proposal`
- `agent-proposal`
- `workshop-autonomous`

For automated work, include the available session key, run id, or automation id
in `Source-Context`. Never put secrets or unnecessary private conversation text
in commit metadata.

## After committing

1. Confirm the commit contains no unrelated paths.
2. Re-run the decisive validation from the committed tree.
3. Push the canonical remote unless the owner explicitly requested local-only
   or staged-only work.
4. Complete every `requiredOnChange` publication in
   `repository-publication.json`.
5. Verify each required remote contains the published commit or registered
   projection before reporting completion.

For a teammate proposal, a proposal-branch commit is auditability, not approval
to merge or activate it. Direct Workshop `auto` work without its required
provenance commit is incomplete; proposal/apply work relies on its managed
Workshop record instead.
