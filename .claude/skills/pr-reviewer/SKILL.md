---
name: pr-reviewer
description: Review multiple related pull requests for a single task. Use when developers provide PR URLs for review. Fetches PR metadata, analyzes code quality, security, testing, architecture, and infers task list of what was accomplished.
version: 1.0.0
---

# PR Reviewer Skill

Reviews one or more related pull requests with comprehensive AI analysis.

## When This Skill Applies

Use this skill when:
- User provides GitHub/GitLab PR URLs for review
- Developer asks for PR review feedback
- Multiple related PRs need coordinated analysis
- Task involves evaluating pull request quality

## How to Invoke

When you see PR URLs in the user's message:

1. Extract the PR URLs
2. Run: `.claude/skills/pr-reviewer/pr-reviewer.sh <URLs>`
3. Analyze the output
4. Provide comprehensive review

## Usage Format

Single PR:
```bash
.claude/skills/pr-reviewer/pr-reviewer.sh https://github.com/org/repo/pull/123
```

Multiple PRs (pipe separator):
```bash
.claude/skills/pr-reviewer/pr-reviewer.sh https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/124
```

With options:
```bash
.claude/skills/pr-reviewer/pr-reviewer.sh --focus security --context "Auth" URL1|URL2
```

## What It Analyzes

- Code quality (structure, naming, duplication, complexity)
- Security (auth, validation, SQL injection, XSS, secrets)
- Testing (coverage, quality, edge cases)
- Architecture (patterns, separation, API design)
- Performance (queries, caching, efficiency)
- Documentation (comments, API docs)

## Output Format

- Executive Summary (assessment, risk level, findings count)
- Critical/High/Medium/Low Priority Findings
- Cross-PR Analysis (dependencies, conflicts)
- Task List (inferred developer accomplishments)
- Recommendations (actionable next steps)

## Requirements

- `gh` CLI installed and authenticated (GitHub)
- `glab` CLI installed and authenticated (GitLab)
