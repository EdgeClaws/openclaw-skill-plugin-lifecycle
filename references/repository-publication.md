# Repository and Publication Registry

`repository-publication.json` is the single source for where an artifact must be
committed and whether a standalone GitHub publication must be updated.

## Interpret the registry

- An unlisted repository/workspace artifact belongs to its enclosing Git root.
  Commit and push that canonical remote by default.
- `publications: []` means the canonical repository is the only publication.
- `requiredOnChange: true` means the listed publication is part of completing
  any change to that artifact.
- `git-subtree` publishes the registered prefix without duplicating or
  relocating the canonical workspace files.
- A curated or sanitized export must use a distinct method value and explicit
  update rule; never imply byte-for-byte mirroring.

For the lifecycle skill, publish the committed workspace prefix with:

```sh
git subtree split --prefix=skills/openclaw-skill-plugin-lifecycle <commit>
git push <publication-repository> <split-commit>:main
```

Verify the remote branch resolves to the split commit before reporting the
publication complete. Do not publish uncommitted working-tree content.

## Add a mapping

Add an artifact entry when a skill or plugin gains a standalone repository.
Record the repository URL, branch, method, source prefix when applicable, and
whether every change requires publication. The workspace owner must approve
registry changes; a delegated maintainer cannot create or alter its own route.

Operators adopting this skill should replace the example mappings while
retaining the enclosing-Git-root default.
