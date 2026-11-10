---
name: yab-browser
version: 3
description: Use Yab on this Mac for browser tasks that need the user's signed-in sites, an explicitly selected tab, browsing history or Yab settings. Supports delegated tasks and direct browser tools.
---

# Yab

Work in agent tabs so the user can keep browsing. Use a user's existing tab only when they
explicitly ask to work there. A site name alone is not permission to take over their tab.

Choose how to work:

- **Delegate a task** when you want a result from Yab's agent:
  `yab "Find the unread message from Alex in Slack and summarize it" --access browser`.
  This starts a separate AI run using the plan selected in Yab.
- **Drive tabs yourself** with the yab-browser MCP tools: `open`, `snapshot`, `click`, `type`.
  Read `yab guide mcp` for the workflow and the offered schemas for exact arguments.
- **Use a shell without MCP**: `yab exec 'const t = open("https://example.com"); return t.snapshot()'`.
  Exec runs browser tools directly, without another model. `exec --help` lists its limits.

A delegated task prints `session <id>`, progress and its answer. Exit 3 means it needs the user:
tell them what is waiting. For a question, ask them, then run
`yab session resume SESSION_ID "their answer"`. Sign-ins and approvals may need Yab.
`session list` finds task ids; `session steer SESSION_ID "new direction"` redirects a task;
`session stop SESSION_ID` stops it. Keep the user informed while a task runs.

Use `--access browser` for website work. Request `--access full` only when files or the terminal
are needed, with full file paths. Use `--no-person` only when nobody can answer requests.

Read a snapshot before acting; don't guess refs. Read the site's skill when offered.
Only send, post, pay or delete when asked. Respect refusals. Use `sign_in` for saved passwords;
hand captchas and sign-ins you cannot complete to the user with `handoff`.
Control Yab through its tools, not Computer Use, AppleScript or desktop keystrokes.

For Yab settings, inspect `native_context` and `native_actions`, then use a listed action with
`native_apply`. Use `yab guide` for more examples and `yab guide setup` for setup.
If the command is missing, the user can install it in Settings › Developers.
If agents are disabled, ask the user to enable Let agents use Yab there.
