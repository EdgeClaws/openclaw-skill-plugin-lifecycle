# Authoring Governance

Use this reference before creating, updating, publishing, auditing, or retiring
an OpenClaw skill, plugin, extension, reusable procedure, or durable project
package.

## Jurisdiction matrix

| Artifact | Live authority | Jared-led | Teammate-led | Agent-initiated |
|---|---|---|---|---|
| Workspace/repository skill | Jared | Apply, verify, commit, push | Stage committed branch/PR or proposal; Jared decides | Stage and ask Jared before live mutation |
| OpenClaw or Codex plugin outside Workshop | Jared | Apply, verify, commit, push | Stage committed branch/PR or proposal; Jared decides | Stage and ask Jared before live mutation |
| Workshop-owned skill | Workshop policy under Jared's expectations | Complete requested live outcome unless audit/proposal-only | May apply after conflict, expectation, and evidence review | May maintain under configured mode after Git gate |
| Procedure | Owning repository plus the skill/plugin it supports | Apply and commit | Stage committed suggestion | Stage and ask before changing authority |

Jared's instruction in the active conversation overrides an older standing
route. No teammate request or autonomous run can expand its authority beyond
the row above.

## Required preflight

1. Read the complete current artifact and directly linked authoring references.
2. Search the likely owner, neighboring skills/plugins, and pending Workshop
   proposals for overlap or contradiction.
3. Check upstream when the artifact mirrors another repository.
4. Resolve the canonical editable source before touching generated, installed,
   cached, or published copies.
5. Identify the initiation class and intended live/staged outcome.

## Workshop behavior

- `off`: no autonomous capture; foreground repair is disabled.
- `propose`: a qualifying review may create or revise one pending proposal.
- `auto`: qualifying per-turn and weekly reviews directly maintain the Workshop
  directory with normal file tools; a newly created foreground repair proposal
  is applied immediately.
- Changing to `auto` does not itself iterate through and apply old pending
  proposals. Existing proposals retain their recorded lifecycle state.
- Direct auto maintenance has no proposal rollback snapshot, post-turn scanner,
  or automatic Git commit.

Therefore, use `auto` only after the Workshop directory and every autonomous
edit path satisfy the lifecycle skill's Git and recovery gates.

## Conflict review for Workshop changes

Before accepting a teammate or autonomous Workshop update:

1. Compare its trigger and behavior with every plausible existing owner.
2. Check Jared's durable requirements and the originating conversation.
3. Prefer updating or consolidating an owner over adding a near-duplicate.
4. Preserve distinct workflows when similarity is only vocabulary.
5. Reject transient incidents, task artifacts, personal facts, unresolved
   guesses, and rules already enforced elsewhere.
6. Validate the complete result and commit the exact accepted state with origin
   provenance.

## Canonical implementation guides

- OpenClaw Skill Workshop:
  `/opt/homebrew/lib/node_modules/openclaw/docs/tools/skill-workshop/`
- General OpenClaw skill creation:
  `/opt/homebrew/lib/node_modules/openclaw/docs/tools/creating-skills.md`
- OpenClaw plugin implementation: `skills/plugin-creator/SKILL.md`
- Codex skill authoring: active system `skill-creator`
- Codex plugin packaging: active system `plugin-creator`
