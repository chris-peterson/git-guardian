# Changelog

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
