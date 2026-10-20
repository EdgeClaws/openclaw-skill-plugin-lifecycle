# Autonomous Workshop Governance

## Purpose

OpenClaw's autonomous Skill Workshop reviews run outside the normal foreground
bootstrap. A pointer in `AGENTS.md` therefore does not guarantee that those
runs receive this lifecycle skill or can inspect repository-owned skills.

`workshop-governance-context` is a thin runtime adapter. It reads the canonical
lifecycle `SKILL.md` at each targeted review, builds a compact index from the
current workspace `skills/*/SKILL.md` files, and adds both to the review's
system context. The lifecycle skill remains the sole policy owner.

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
- Fail closed before model inference when a targeted review lacks the injected
  governance marker.
- Leave unrelated turns untouched.

The standalone source is `EdgeClaws/openclaw-workshop-governance`. Its plugin
ID is `workshop-governance-context`. A non-bundled installation requires:

```json5
{
  plugins: {
    entries: {
      "workshop-governance-context": {
        enabled: true,
        hooks: { allowConversationAccess: true },
        config: {}
      }
    }
  }
}
```

`allowPromptInjection` must not be disabled. Restart the Gateway after plugin
code or discovery-path changes so it receives the cron reconciliation
baseline.

## Proof before relying on it

1. Run the plugin's focused tests and package dry run.
2. Inspect the loaded runtime and confirm registrations for
   `before_prompt_build`, `before_agent_run`, `cron_reconciled`, and
   `cron_changed`.
3. In an isolated OpenClaw state/workspace, prove identical lifecycle context
   reaches per-turn `propose`, per-turn `auto`, and weekly `auto` reviews.
4. Prove an ordinary turn receives no injected context and a targeted run with
   missing governance is blocked.
5. Re-run the contract tests after OpenClaw upgrades because the review run and
   cron identities are host contracts.

## Auto mode remains separately gated

This plugin supplies governance awareness only. It does not create Git commits,
rollback snapshots, or recovery points. Do not enable Workshop `auto` until the
Git/provenance and recovery gates in the parent skill are independently proven.
