#!/usr/bin/env node

import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const skillDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

async function readJson(relativePath) {
  return JSON.parse(
    await fs.readFile(path.join(skillDir, relativePath), "utf8"),
  );
}

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

const ownership = await readJson("references/authoring-ownership.json");
assert(ownership.schemaVersion === 1, "unsupported ownership schema");
assert(
  typeof ownership.defaultPolicy?.workspaceOwner === "string",
  "workspace owner is required",
);
assert(
  ownership.principals?.[ownership.defaultPolicy.workspaceOwner],
  "workspace owner must be a declared principal",
);

const grantKeys = new Set();
for (const grant of ownership.grants ?? []) {
  assert(
    typeof grant.artifact === "string" && grant.artifact.startsWith("skills/"),
    "grant artifact must be a workspace skill path",
  );
  assert(ownership.principals?.[grant.principal], "grant principal is unknown");
  assert(grant.role === "maintainer", "unsupported grant role");
  const key = `${grant.artifact}\0${grant.principal}`;
  assert(!grantKeys.has(key), "duplicate artifact/principal grant");
  grantKeys.add(key);
}

const repositories = await readJson(
  "references/repository-publication.json",
);
assert(repositories.schemaVersion === 1, "unsupported repository schema");
assert(
  repositories.defaults?.canonicalRepository === "enclosing-git-root",
  "canonical repository default must be enclosing-git-root",
);

for (const [artifact, policy] of Object.entries(
  repositories.artifacts ?? {},
)) {
  assert(artifact.length > 0, "repository artifact key is empty");
  for (const publication of policy.publications ?? []) {
    assert(
      /^https:\/\/github\.com\/[^/]+\/[^/]+$/u.test(publication.repository),
      "publication must be a GitHub repository URL",
    );
    assert(publication.branch, "publication branch is required");
    assert(
      ["git-subtree", "curated-export", "sanitized-export"].includes(
        publication.method,
      ),
      "unsupported publication method",
    );
    if (publication.method === "git-subtree") {
      assert(publication.prefix, "git-subtree publication requires a prefix");
    }
  }
}

console.log("PASS: lifecycle ownership and repository registries");
