# PR Reviewer - Quick Start Guide

## Installation Check

Run the test script to verify setup:
```bash
.claude/skills/pr-reviewer/test.sh
```

## Install Required Tools

### GitHub CLI (gh)
```bash
# Ubuntu/Debian
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Login
gh auth login
```

### GitLab CLI (glab) - Optional
```bash
# Ubuntu/Debian
sudo apt install glab

# Login
glab auth login
```

## Usage Examples

### Single PR Review
```bash
/pr-reviewer https://github.com/owner/repo/pull/123
```

### Multiple Related PRs
```bash
/pr-reviewer https://github.com/owner/repo/pull/123|https://github.com/owner/repo/pull/124
```

Note: Use pipe `|` to separate multiple PR URLs.

### Security-Focused Review
```bash
/pr-reviewer --focus security https://github.com/owner/repo/pull/123
```

### With Context
```bash
/pr-reviewer --context "Payment Gateway Integration" https://github.com/owner/repo/pull/123 https://github.com/owner/repo/pull/456
```

## What Gets Reviewed

- **Code Quality**: Structure, naming, duplication, complexity
- **Security**: Auth, input validation, SQL injection, XSS
- **Testing**: Coverage, quality, edge cases
- **Architecture**: Design patterns, separation of concerns
- **Performance**: Database queries, caching, efficiency
- **Documentation**: Comments, API docs

## Review Output

You'll receive:
- Executive summary with overall assessment
- Critical/High/Medium/Low priority findings
- Cross-PR dependency analysis
- **Task list** - inferred developer tasks from PRs
- Actionable recommendations

## Configuration

Edit `.claude/pr-reviewer.json` to customize:
- Default focus areas
- Security rules
- Review templates
- Integration settings
