# Changelog

## 0.4.2

### Fixes
- The watchdog hook now logs malformed-JSON input to stderr instead of failing silently, making bad-payload incidents diagnosable.

### Other
- Plugin description in `plugin.json` no longer says "enforce" (typo) or "claude-watches" (wrong tool name); now reads "enforces command safety rules via 'claude-watchdog'".
- Added internal contributor docs — `SPEC.md` (formal contract), `STATUS.md` (spec-coverage audit), and `AGENTS.md` (build philosophy) — so future agent sessions and human contributors have a reading order. `CLAUDE.md` now imports `AGENTS.md`.

## 0.4.1

### Fixes
- The watch-secrets `env` / `printenv` ask-rule no longer triggers on hyphenated tokens like `data-env` or `printenv-extra` appearing in comments or filenames. The previous regex used `\b...\b` boundaries, which treat hyphens as word separators; the rule now requires shell command boundaries (start of line, whitespace, `;`, `&&`, `|`, backtick, parens) on both sides.

## 0.4.0

### Other
- Adopted the `SessionStart` cli-freshness hook pattern from the chris-peterson plugin namespace for symmetry. ClaudeWatch is a pure-hook plugin with no `install-cli` wrapper to drift, so the handler is intentionally empty (one comment, `exit 0`); it exists as a placeholder for future plugin-update self-checks specific to a hook plugin (e.g., verifying `watchdog.py` emits the expected `permissionDecision` schema — the kind of regression that shipped silently in 0.2.0).

## 0.3.0

### Other
- Established `plugin.json` as the single source of truth for the version. The project is moving to a main-only release model with no version tags; existing tags (`1.0.0`, `0.0.2`) will be deleted separately.
- Added an "Updating" section to the README documenting the auto-update path for end users.

## 0.2.1

### Fixes
- Ask-rules now actually prompt the user. Prior versions emitted the legacy hook output schema, which Claude Code silently treated as no-op for `ask` decisions — meaning every ask-rule (`git push`, `git commit`, `npm install`, etc.) was allowed through without confirmation. Updated to the current `hookSpecificOutput.permissionDecision` schema; both `deny` and `ask` decisions now route through it.
