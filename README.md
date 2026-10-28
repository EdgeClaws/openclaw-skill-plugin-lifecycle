# OpenClaw Skill + Plugin Lifecycle

Portable governance for deciding who may edit repository-owned OpenClaw
skills/plugins, routing unowned work into Skill Workshop, preserving audit
history, and publishing canonical changes.

## Install

1. Copy this directory to
   `skills/openclaw-skill-plugin-lifecycle/` in the agent workspace.
2. Point the workspace `AGENTS.md` authoring route at `SKILL.md`.
3. Replace the owner, principals, and grants in
   `references/authoring-ownership.json`.
4. Replace or extend `references/repository-publication.json`.
5. Run `bash scripts/test.sh`.

The identity registry deliberately stores canonical principals rather than
channel IDs. Bind Telegram, Slack, and future accounts to those principals in
one workspace identity directory.

## Autonomous Workshop reviews

OpenClaw's detached Workshop reviews may not receive normal workspace bootstrap
instructions. Follow
`references/workshop-autonomous-governance.md` to install the optional
`workshop-governance-context` adapter, which loads this skill and both
registries dynamically.

The adapter source is published at
https://github.com/EdgeClaws/openclaw-workshop-governance.
