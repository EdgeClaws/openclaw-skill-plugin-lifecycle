# Authoring Governance

Use this reference before creating, updating, publishing, auditing, or retiring
an OpenClaw skill, plugin, extension, reusable procedure, or durable project
package.

## Jurisdiction matrix

| Artifact | Owner-led | Granted maintainer | Other teammate | Agent-initiated |
|---|---|---|---|---|
| Workspace/repository skill | Apply, verify, commit, publish | Same, exact registered path only | New skill → Workshop; existing skill → staged proposal | New skill → Workshop; existing skill → stage and ask owner |
| OpenClaw or Codex plugin outside Workshop | Apply, verify, commit, publish | Same only when explicitly registered | Stage branch/PR; owner decides | Stage and ask owner |
| Workshop-owned skill | Complete requested live outcome unless proposal-only | Registry does not govern Workshop storage | May apply after conflict and evidence review | Maintain under configured mode; direct `auto` still needs Git gate |
| Procedure | Apply and commit in owning repository | Only when inside registered artifact | Stage committed suggestion | Stage and ask before changing authority |

The workspace owner's instruction in the active conversation overrides an
older standing route. No maintainer, teammate, or autonomous run can expand its
own authority.

## Required preflight

1. Read the complete current artifact and directly linked authoring references.
2. Resolve the requester through `authoring-ownership.json` and
   [ownership and identity](ownership-and-identity.md).
3. Search the likely owner, neighboring skills/plugins, and pending Workshop
   proposals for overlap or contradiction.
4. Check `repository-publication.json` and upstream when the artifact has
   another publication.
5. Resolve the canonical editable source before touching generated, installed,
   cached, or published copies.
6. Identify the initiation class and intended live/staged outcome.

## Workshop behavior

- `off`: no autonomous capture; foreground repair is disabled.
- `propose`: a qualifying review may create or revise one pending proposal.
- `auto`: qualifying per-turn and weekly reviews directly maintain the Workshop
  directory with normal file tools; a newly created foreground repair proposal
  is applied immediately.
- Changing to `auto` does not itself iterate through and apply old pending
  proposals. Existing proposals retain their recorded lifecycle state.
- Proposal-based changes retain immutable generations, events, hashes, and
  apply rollback metadata; a duplicate Git commit is not required.
- Direct auto maintenance has no proposal rollback snapshot, separate review
  history, or automatic Git commit.

Therefore, use `auto` only after the Workshop directory and every autonomous
edit path satisfy the lifecycle skill's Git and recovery gates.

## Conflict review for Workshop changes

Before accepting a teammate or autonomous Workshop update:

1. Compare its trigger and behavior with every plausible existing owner.
2. Check the workspace owner's durable requirements and originating context.
3. Prefer updating or consolidating an owner over adding a near-duplicate.
4. Preserve distinct workflows when similarity is only vocabulary.
5. Reject transient incidents, task artifacts, personal facts, unresolved
   guesses, and rules already enforced elsewhere.
6. Validate the complete result and preserve origin provenance through its
   managed proposal record or, for direct `auto`, the required Git commit.

## Canonical implementation guides

- OpenClaw Skill Workshop:
  `/opt/homebrew/lib/node_modules/openclaw/docs/tools/skill-workshop/`
- General OpenClaw skill creation:
  `/opt/homebrew/lib/node_modules/openclaw/docs/tools/creating-skills.md`
- OpenClaw plugin implementation: `skills/plugin-creator/SKILL.md`
- Codex skill authoring: active system `skill-creator`
- Codex plugin packaging: active system `plugin-creator`
