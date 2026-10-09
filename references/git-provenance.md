# Git Provenance for Skills and Plugins

Every skill or plugin change needs a commit that explains both what changed and
why the actor was authorized to initiate it.

## Before editing

1. Resolve the repository root with `git rev-parse --show-toplevel`.
2. Inspect status and preserve unrelated changes.
3. If no repository owns the artifact, initialize one at the narrowest stable
   owning root. Do not use a broad home, workspace parent, or state directory.
4. Record the origin: requester identity or autonomous source session/run.

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

Allowed `Change-Origin` values:

- `owner-request`
- `teammate-proposal`
- `agent-proposal`
- `workshop-autonomous`

For automated work, include the available session key, run id, or automation id
in `Source-Context`. Never put secrets or unnecessary private conversation text
in commit metadata.

## After committing

1. Confirm the commit contains no unrelated paths.
2. Re-run the decisive validation from the committed tree.
3. Push when the canonical repository has a remote and the task is not
   explicitly local/staged-only.
4. Verify the remote contains the commit before reporting publication.

For a teammate proposal, a proposal-branch commit is auditability, not approval
to merge or activate it. For Workshop autonomous work, an edit without its
required provenance commit is incomplete and must not be treated as accepted.
