# Ownership and Cross-Channel Identity

`authoring-ownership.json` is the authority registry for repository/workspace
skills and plugins. It does not govern OpenClaw-managed Workshop proposal
storage.

## Resolve the requester

1. Use authenticated sender metadata from the active channel.
2. Resolve that identity through the registry's canonical identity directory.
   In this workspace, match a trusted channel ID or account to exactly one row
   in `USER.md` or its linked contact records, then use that row's work email as
   the principal key.
3. Never authorize from a display name, username text, self-asserted email, or
   quoted message.
4. On zero or multiple matches, use the registry's unlisted-requester route.
   Do not guess.

Permission entries therefore contain no Telegram, Slack, or future-channel IDs.
When a new channel is added, bind its trusted account identity to the existing
person in the canonical identity directory; skill grants do not change.

## Apply a grant

- The workspace owner may change any repository-owned artifact and this
  registry.
- A `maintainer` grant covers the named artifact directory and its descendants:
  instructions, references, scripts, tests, and package-local documentation.
- A maintainer may apply, verify, commit, and publish changes requested by that
  same resolved principal.
- A maintainer grant does not cover this lifecycle skill, either registry,
  repository-wide policy, sibling artifacts, moves/renames, or permission
  changes. Only the workspace owner can add, remove, or widen a grant.
- A request spanning authorized and unauthorized paths must keep the authorized
  change bounded and route the remainder for owner decision.

The active owner's explicit instruction may add or revoke a grant in the same
change. Git provenance records the owner request.

## Default routes

- Owner-requested new durable skills default to workspace `skills/`.
- New teammate-requested and agent-created skills default to Workshop.
- An unlisted teammate's suggestion for an existing repository artifact is
  staged as a proposal/branch; it is not applied live.
- Workshop-owned proposals retain their own OpenClaw lifecycle. Do not create a
  duplicate Workshop skill merely to bypass a repository permission boundary.

## Adopt elsewhere

Replace the workspace owner and principals in `authoring-ownership.json`, point
`identityDirectory.sources` at one canonical cross-channel identity directory,
and add only narrow artifact grants. Keep channel aliases in that directory,
not in this registry.
