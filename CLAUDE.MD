# Daily Tasks Skills

## Git PR Reviewer

Review multiple related pull requests with comprehensive AI analysis.

**Usage**: `/pr-reviewer <PR_URL>[|<PR_URL>...] [--focus AREA] [--context TEXT]`

**Example**: `/pr-reviewer https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/124`

**Features**:
- Multi-PR review (use pipe `|` separator)
- Security, performance, architecture analysis
- Task list inference (what developer accomplished)
- Cross-PR dependency analysis

**See**: `.claude/skills/pr-reviewer/QUICKSTART.md` for full documentation
