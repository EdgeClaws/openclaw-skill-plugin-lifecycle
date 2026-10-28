# Autonomous Workshop Governance

## Purpose

OpenClaw's autonomous Skill Workshop reviews run outside the normal foreground
bootstrap. A pointer in `AGENTS.md` therefore does not guarantee that those
runs receive this lifecycle skill or can inspect repository-owned skills.

`workshop-governance-context` is a thin runtime adapter. At each targeted
review, it reads the canonical lifecycle `SKILL.md`, the ownership and
repository-publication registries, and a compact index built from the current
workspace skill files. The lifecycle bundle remains the sole policy owner.

## Covered lanes

- detached per-turn experience review in Workshop `propose` mode;
- detached per-turn maintenance in Workshop `auto` mode;
- the system-owned weekly collection review enabled by `auto` mode.

The plugin does not target ordinary foreground turns. Normal skill routing
continues to govern foreground repair and explicit authoring work.

## Runtime contract

- Identify per-turn reviews by OpenClaw's `skill-workshop-review:` run prefix.
- Identify weekly reviews from the system cron declaration prefix
  `skill-collection-review:` and its canonical cron session identity.
- Never classify a run by matching natural-language prompt text.
- Inject the lifecycle source dynamically; do not embed a second copy in code.
- Inject `references/authoring-ownership.json` and
  `references/repository-publication.json` dynamically. If either is missing,
  use the lifecycle's owner-only fallback; never infer a grant.
- Keep the adapter to context injection; do not add a second review or prompt
  gate solely to verify its own output.
- Leave unrelated turns untouched.

## Portable installation

The standalone source is
`https://github.com/EdgeClaws/openclaw-workshop-governance`. Its plugin ID is
`workshop-governance-context`.

1. Clone the repository into a durable path outside the OpenClaw package
   installation.
2. Run `npm test` and `npm pack --dry-run`.
3. Run `openclaw plugins install --link --force .` from that checkout.
4. Merge the following entry into `~/.openclaw/openclaw.json`, preserving
   existing plugin paths, allowlists, and entries:

```json5
{
  plugins: {
    entries: {
      "workshop-governance-context": {
        enabled: true,
        hooks: { allowConversationAccess: true },
        config: {
          lifecycleSkillPath:
            "skills/openclaw-skill-plugin-lifecycle/SKILL.md",
          governanceReferencePaths: [
            "skills/openclaw-skill-plugin-lifecycle/references/authoring-ownership.json",
            "skills/openclaw-skill-plugin-lifecycle/references/repository-publication.json"
          ]
        }
      }
    }
  }
}
```

`allowPromptInjection` must not be disabled. `workspaceDir` is optional for a
nonstandard workspace. Run `openclaw config validate` and
`openclaw plugins inspect workshop-governance-context --runtime --json`.

The loaded plugin must register exactly `before_prompt_build`,
`cron_reconciled`, and `cron_changed`. Restart the Gateway after plugin code
or discovery-path changes so it receives the cron reconciliation baseline, but
follow the host's restart-authorization policy.

## Proof before relying on it

1. Run the plugin's focused tests and package dry run.
2. Inspect the loaded runtime and confirm registrations for
   `before_prompt_build`, `cron_reconciled`, and `cron_changed`.
3. In an isolated OpenClaw state/workspace, prove identical lifecycle context
   and both registries reach per-turn `propose`, per-turn `auto`, and weekly
   `auto` reviews.
4. Prove an ordinary turn receives no injected context.
5. Re-run the contract tests after OpenClaw upgrades because the review run and
   cron identities are host contracts.

## Auto mode remains separately gated

This plugin supplies governance awareness only. It does not create Git commits,
rollback snapshots, or recovery points. Do not enable Workshop `auto` until the
Git/provenance and recovery gates in the parent skill are independently proven.
