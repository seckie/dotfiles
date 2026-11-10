# CLAUDE.md (user-level)

## Communication

<!-- @see: https://platform.claude.com/docs/ja/build-with-claude/prompt-engineering/prompting-claude-opus-5 -->
Keep responses focused, brief, and concise. Keep disclaimers and caveats short, and spend most of the response on the main answer. When asked to explain something, give a high-level summary unless an in-depth explanation is specifically requested.

## Subagent

<!-- @see: https://platform.claude.com/docs/ja/build-with-claude/prompt-engineering/prompting-claude-opus-5 -->
Delegate to a subagent only for large tasks that are genuinely independent and parallelizable, such as a wide multi-file investigation. Do not delegate work you can finish yourself in a handful of tool calls, and do not use subagents to verify or double-check your own work. If one subagent can complete the task, use one rather than several, and keep spawn counts low.

## GitHub CLI (gh)

Run `gh` as a standalone Bash tool call so the existing `gh *` or `rtk gh *` sandbox exclusion applies. For subcommands that support it, specify the repository with `--repo OWNER/REPO` instead of using `cd repo && gh ...`. For `gh api`, include the repository in the endpoint, such as `repos/OWNER/REPO/pulls/123`. Keep command chains, pipes, redirections, command substitutions, and shell control flow out of the call; prepare inputs and process outputs in separate tool calls. For multiline text, prepare a file first and use options such as `--body-file` where supported.

Excluded commands run outside the sandbox and still follow normal permission rules. On macOS, `x509: OSStatus -26276` can affect both REST and GraphQL; switching APIs does not fix it. If it occurs, check that the call is standalone and matches an exclusion before retrying.

@RTK.md
