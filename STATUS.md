# ClaudeWatch — Spec Coverage Status

Tracking status of the requirements declared in [SPEC.md](SPEC.md). Updated
whenever an audit (`/spec-audit`) is run, when implementation lands, or when
the spec is revised.

**Last audit:** 2026-05-08
**Spec version:** v1 (root SPEC.md, no versioned tree)
**Coverage:** 50 / 56 normative requirements (89%) + 3 deferred

## Status table

| ID | Requirement | Status | Evidence |
|----|-------------|--------|----------|
| EN-01..EN-11 | Engine lifecycle, IO, error handling | Covered | `scripts/watchdog.py` |
| EN-04a | Log JSON parse error to stderr | Covered | `scripts/watchdog.py:166-168` |
| EN-05a | No-arg fallback to `../rules` | Covered | `scripts/watchdog.py:177-180` |
| RS-01..RS-06 | Rule set format and discovery | Covered | `scripts/watchdog.py:25-98, 191-198` |
| RL-01..RL-09 | Rule fields, evaluation order, error handling | Covered | `scripts/watchdog.py:108-159` |
| OUT-01..OUT-05 | Output decisions, formatting, aggregation | Covered | `scripts/watchdog.py:101-105, 199-215` |
| HK-01 | PreToolUse Bash hook | Covered | `hooks/hooks.json:3-13` |
| HK-02 | SessionStart hook (no-op placeholder) | Covered | `hooks/hooks.json:14-23`, `hooks/cli-freshness.sh` |
| HK-03 | Hooks declared in hooks.json | Covered | `hooks/hooks.json` |
| EXT-01..EXT-03 | Auto-discovery, disable-by-rename, no-code-change | Covered | `scripts/watchdog.py:191-194`, `tests/test-engine.sh` |
| SK-01 | `/ClaudeWatch:help` overview | Covered | `skills/help/SKILL.md` |
| SK-02..SK-12 | `/ClaudeWatch:rules` interactive editor | Covered | `skills/rules/SKILL.md` |
| DOC-01..DOC-04 | Docsify site, `just docs`, GitHub Pages, schema | Covered | `docs/`, `build/gen-rules-doc.py`, `justfile` |
| DIST-01 | Marketplace install | Covered (extrinsic) | Verified via README + `plugin.json#repository`; marketplace lives in sibling repo `claude-marketplace` |
| DIST-02 | `.claude-plugin/plugin.json` manifest | Covered | `.claude-plugin/plugin.json` |
| DIST-03 | Runnable via `claude --plugin-dir .` | Covered | `justfile:14-15` (`just try`) |
| SH-01 | `watch-git` block + ask enumeration | Covered | `rules/watch-git.yml` |
| SH-01a | Git pre-subcommand flags handling | Covered | `rules/watch-git.yml` (regex prefix on every rule), `tests/test-watch-git.sh:85-104` |
| SH-02 | `watch-installs` rules | Covered | `rules/watch-installs.yml` (spec updated 2026-05-08 to match shipped rules) |
| SH-03 | `watch-files` rules + cache/tmp `except` | Covered | `rules/watch-files.yml` (spec updated 2026-05-08) |
| SH-04 | `watch-secrets` rules | Covered | `rules/watch-secrets.yml` (spec updated 2026-05-08) |
| SH-04a | Shell-command boundaries on full-token rules | Covered | `rules/watch-secrets.yml:43-44` (env/printenv rule) |
| SH-05..SH-07 | Filter regex / refs / per-set tests | Covered | All four `rules/*.yml` + `tests/test-watch-*.sh` |
| DEV-01..DEV-04 | `just test`, test layout, `just rules`, `just docs-preview` | Covered | `justfile` + `tests/` |
| FUT-01 | SessionStart self-check | Deferred | `hooks/cli-freshness.sh` is intentional no-op |
| FUT-02 | `new` rule-set scaffolds a test file | Deferred — partially covered | `skills/rules/SKILL.md:155-159` already offers this; consider promoting |
| FUT-03 | Multi-line YAML strings / anchors | Deferred | Not needed by current rules |

## Audit history

### 2026-05-08 — Initial bootstrap audit

Spec was drafted retroactively from the implementation, then audited. Findings
applied this session:

- **Spec edits (SPEC.md)**
  - SH-02 rewritten to enumerate the 5 shipped block rules and 11 ask rules
    (dropped fictional `sudo apt`, added `wget|sh`, `brew install`, `pnpm`,
    `cargo`, `go`, `gem`, `composer`, `npx`).
  - SH-03 rewritten to include `rm -rf /*`, `rm -r`, `mv /`, and the cache/tmp
    `except` whitelist.
  - SH-04 rewritten to enumerate all 7 ask rules (PEM/key reads, secret-name
    file reads, export-secret-inline, `.env`, etc.).
  - Added SH-01a (git pre-subcommand-flag handling) — promotes a security-
    relevant regex pattern to a normative requirement.
  - Added SH-04a (shell-command boundaries on full-token rules).
  - Added EN-04a (stderr logging on JSON parse failure).
  - Added EN-05a (explicit no-arg fallback to `../rules`).
  - SK-05 expanded to enumerate all 7 edit operations including `<id>:allow`
    and `<id>:ask`.

- **Code edits**
  - `scripts/watchdog.py`: log JSON parse errors to stderr (EN-04a).
  - `.claude-plugin/plugin.json`: fix description typo
    (`enforce` → `enforces`, `claude-watches` → `claude-watchdog`).
  - `AGENTS.md`: fix cross-reference typo (`SH/FUT-01` → `FUT-01`).

- **Open items (not addressed this pass)**
  - Engine no-arg fallback (`scripts/watchdog.py:177-180`) is now spec'd via
    EN-05a rather than removed. The user's `no-fallbacks` rule prefers loud
    failure; reconsider if the fallback ever masks a real misconfiguration.
  - FUT-02 (`new` scaffolds a test file) is partially implemented and could
    be promoted to a normative SK requirement on next pass.

## How to use this file

When you implement a new requirement, change the row's status to **Covered**
and add an evidence pointer. When an audit reveals drift, update the row's
status to **Partial** or **Contradicts** with a one-line note. New
requirements added to SPEC.md should appear here on the next audit.
