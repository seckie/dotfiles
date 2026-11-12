# AGENTS.md (user-level)

## Browser verification

Keep the default sandbox enabled. On macOS, Chromium launched through a shell
command can fail with `bootstrap_check_in ... Permission denied` or
`MachPortRendezvousServer` errors. These indicate an OS sandbox restriction;
Chromium's `--no-sandbox` flag does not remove the Codex sandbox.

When browser verification encounters these errors, request sandbox escalation
for the specific browser test or verification command and retry it after
approval. Treat `listen EPERM` on a local development server similarly when
local networking is blocked. Do not repeatedly retry the same sandboxed command
or disable the global sandbox to work around these failures. If approval is
unavailable, report that browser verification is blocked.

## Writing

When drafting or revising documents on the user's behalf, read the shared [writing style guide](~/.config/writing/style-guide.md) and consult relevant [examples](~/.config/writing/examples.md) and [revision records](~/.config/writing/revisions.md).

Prioritize the audience, purpose, and style specified for the current document. Apply the guide to ordinary conversation only when explicitly requested. If a referenced file cannot be read, say so. Do not infer preferences from an unedited AI draft or treat a one-off correction as a general rule.
