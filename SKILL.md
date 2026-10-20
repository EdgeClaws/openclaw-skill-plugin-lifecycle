---
name: openclaw-skill-plugin-lifecycle
description: Required before any OpenClaw skill, plugin, extension, or reusable procedure creation, update, publication, audit, or retirement.
---

# OpenClaw Skill + Plugin Lifecycle

Load this skill before changing any skill, plugin, extension, reusable
procedure, or durable authoring package. It owns governance and provenance;
specialized creator skills own implementation details.

## Working principles

- Prefer the smallest useful artifact and the shortest process that proves the
  requested outcome. Do not overengineer routine authoring.
- Prioritize usability and delivered value. Handle recoverable friction as part
  of the work instead of inventing approval gates or blockers.
- Treat edge cases in proportion to demonstrated risk. Preserve real safety,
  authority, privacy, and recovery constraints, but do not let speculative or
  nuanced edge cases prevent reasonable progress.
- These principles are not exhaustive. Every change or proposal must also
  follow the current `SOUL.md`, `USER.md`, `IDENTITY.md`, relevant contact or
  group records, active conversation instructions, and the artifact's owner.

## 1. Classify and locate the owner

Read [authoring governance](references/authoring-governance.md), then choose the
smallest reusable artifact and its canonical source:

- **Procedure:** reusable operational guidance that should not trigger as an
  agent capability.
- **Repository/workspace skill:** a skill in a normal Git checkout, including
  this workspace's `skills/` tree.
- **Workshop skill:** a skill contained in the active agent's
  `workshop-skills/` directory.
- **OpenClaw plugin:** runtime code that adds tools, commands, handlers,
  providers, channels, hooks, or UI.
- **Codex plugin:** a Codex plugin package and marketplace entry.
- **Project unit:** multi-session state that owns several related artifacts.

Search the likely owner, nearby skills, installed OpenClaw docs, and pending
Workshop proposals before creating another identity. One behavior gets one
authoritative owner; references point to it instead of copying its rules.

## 2. Route by initiation and jurisdiction

### Jared-led work

Jared owns every live skill or plugin outside `workshop-skills/`. Apply his
requested change directly to the canonical source, verify it, commit it, and
push when that repository has a remote. Do not add a second approval gate or a
Workshop proposal for repository-owned work.

When Jared requests a new durable skill, create it in this workspace's
`skills/` tree by default. Use `workshop-skills/` only when he explicitly asks
for a Workshop skill or the request updates an artifact already owned there.
The availability of `skill_workshop` does not change this location rule.

For a Jared-requested Workshop change, use the current Workshop lifecycle and
finish the requested live outcome unless Jared explicitly asks for audit-only
or proposal-only work.

### Teammate-led work

- **Outside Workshop:** do not mutate the live artifact. Stage a complete
  suggestion through the owning repository's branch/PR mechanism, or a clearly
  labeled committed proposal artifact when no branch workflow exists. Record
  who requested it and notify Jared for the authority decision.
- **Inside Workshop:** a teammate request may be applied only after checking it
  against Jared's standing expectations, the complete current Workshop skill
  set, pending proposals, and adjacent non-Workshop skills. Reject or
  consolidate conflicts; verify and commit accepted changes.

### Agent-initiated work

- **Outside Workshop:** suggestions are allowed, but stage them clearly and ask
  Jared before changing the live artifact.
- **Inside Workshop:** autonomous exploration, self-creation, and maintenance
  are permitted and encouraged. Read this lifecycle skill first, then proceed
  only under the configured Workshop mode and the Git gate below.

## 3. Use the correct authoring implementation

- For skill structure and quality, use the active `skill-creator` guidance.
- For Workshop proposals, lifecycle actions, storage, and autonomy, read the
  installed OpenClaw docs under
  `/opt/homebrew/lib/node_modules/openclaw/docs/tools/skill-workshop/` and use
  `skill_workshop`; never hand-edit proposal storage.
- For OpenClaw plugins, read `skills/plugin-creator/SKILL.md`, then current
  installed OpenClaw plugin docs and SDK declarations.
- For Codex plugins, use Codex's system `plugin-creator` skill. It is a separate
  product lane from OpenClaw plugins.
- For repository-owned skills, edit with normal repository tools; a `SKILL.md`
  filename alone does not make the artifact Workshop-owned.

Use the installed docs/source as runtime authority when copied examples drift.
Do not treat generated mirrors, caches, installed bundles, or public scrubbed
copies as canonical editable sources.

## 4. Workshop safety gates

Workshop `propose` mode stages pending proposals. Workshop `auto` mode permits
new background reviews to edit the Workshop tree directly and permits a newly
created foreground repair proposal to be applied immediately. It does not make
the existing pending backlog live merely because the setting changes.

Do not enable or rely on Workshop `auto` until all of these are true:

1. The complete Workshop tree is Git-backed.
2. Every autonomous edit path demonstrably creates a provenance-bearing commit.
3. The tree has been checked for duplicate or conflicting skills and pending
   proposals.
4. Recovery from the Git history has been tested.

Stock auto maintenance has no proposal rollback snapshot and no automatic Git
commit. Until the gates are proven, keep autonomous mode at `propose` or `off`.
Never change the mode as a side effect of authoring work.

Autonomous Workshop review runs do not inherit this skill merely because it is
listed in `AGENTS.md`. Keep the scoped `workshop-governance-context` plugin (or
an equivalent host mechanism) enabled so per-turn reviews in `propose` and
`auto`, plus the weekly `auto` review, dynamically receive this canonical skill
and a current repository-skill owner index. The adapter must fail closed when
that context is unavailable and must not copy policy into plugin code. See
[autonomous Workshop governance](references/workshop-autonomous-governance.md).
This context gate does not satisfy the separate Git/provenance requirements for
`auto` mode.

For proposal updates, read the complete live skill first. The proposal must be
the complete intended next `SKILL.md`, not a change-description essay. Inspect,
evaluate when available, apply only within the initiation rules above, and
compare the live result byte-for-byte with the intended content.

## 5. Verify the artifact

Use checks proportional to the artifact:

- skill: validate frontmatter, name/description routing, references, scripts,
  overlap, and `openclaw skills check`;
- OpenClaw plugin: validate manifest/package identity, current SDK types,
  build output, discovery/load path, focused tests, and real interaction path
  when authorized;
- Codex plugin: use the Codex plugin validator and cachebuster/reinstall flow;
- procedure: confirm its callers point to one current authority.

Inspect the final diff and exclude unrelated dirty-tree changes. A clean scan
or valid frontmatter does not prove sound ownership, non-conflict, or behavior.

## 6. Commit and publish with provenance

Every skill or plugin change requires a Git commit, regardless of storage
location. Read [Git provenance](references/git-provenance.md) before committing.

- If the canonical source has a remote, push the commit unless Jared explicitly
  limits the task to local/staged work.
- If the canonical source has no repository, initialize a local repository at
  the narrowest stable owning root before changing the live artifact.
- Never mix unrelated working-tree changes into the commit.
- Record whether the change was owner-requested, teammate-proposed,
  agent-proposed, or Workshop-autonomous.

Authoring is complete only when the live/staged state matches the intended
authority boundary, validation passes, the provenance commit exists, and any
required remote reflects that commit.
