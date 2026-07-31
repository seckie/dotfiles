# CLAUDE.md (user-level)

## Communication

<!-- @see: https://platform.claude.com/docs/ja/build-with-claude/prompt-engineering/prompting-claude-opus-5 -->
Keep responses focused, brief, and concise. Keep disclaimers and caveats short, and spend most of the response on the main answer. When asked to explain something, give a high-level summary unless an in-depth explanation is specifically requested.

## Subagent

<!-- @see: https://platform.claude.com/docs/ja/build-with-claude/prompt-engineering/prompting-claude-opus-5 -->
Delegate to a subagent only for large tasks that are genuinely independent and parallelizable, such as a wide multi-file investigation. Do not delegate work you can finish yourself in a handful of tool calls, and do not use subagents to verify or double-check your own work. If one subagent can complete the task, use one rather than several, and keep spawn counts low.

