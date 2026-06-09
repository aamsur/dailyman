# PR Reviewer Skill - Complete

## Summary

The PR Reviewer skill is now set up for your IT Manager daily tasks. This skill allows you to review multiple related pull requests efficiently with AI-powered analysis.

## File Structure

```
.claude/
├── pr-reviewer.json                    # Configuration
└── skills/
    └── pr-reviewer/
        ├── skill.md                    # Skill metadata
        ├── README.md                   # Full documentation
        ├── QUICKSTART.md               # Quick start guide
        ├── pr-reviewer.sh              # Main bash script
        ├── pr-reviewer.js              # Node.js wrapper
        ├── test.sh                     # Setup validator
        ├── examples.sh                 # Usage examples
        └── lib/
            ├── logging.sh              # Logging functions
            ├── parser.sh               # URL/arg parsing
            ├── fetcher.sh              # PR data fetching
            └── prompt.sh               # Claude prompt generation
```

## Next Steps

1. **Install GitHub CLI**:
   ```bash
   # Follow: https://cli.github.com
   gh auth login
   ```

2. **Test the skill**:
   ```bash
   .claude/skills/pr-reviewer/test.sh
   ```

3. **Use with Claude**:
   ```bash
   /pr-reviewer https://github.com/owner/repo/pull/123
   ```

## How It Works

1. Developer gives you PR URLs (separated by pipe `|` for multiple PRs)
2. Skill fetches metadata and diffs using gh/glab CLI
3. Generates comprehensive review prompt
4. Claude AI analyzes code across all PRs
5. Infers task list (what developer accomplished)
6. Returns structured findings with priorities

## Key Features

- Multi-PR review in single session (use pipe `|` separator)
- Cross-PR dependency analysis
- Security, performance, architecture checks
- Task list inference from PR changes
- Customizable focus areas
- JSON/Markdown output formats

## Configuration

Edit `.claude/pr-reviewer.json` to adjust:
- Security rules
- Focus areas
- Output format
- Review depth
