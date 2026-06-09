# PR Reviewer Skill - Installation Complete

## ✓ Verification Summary

All files created successfully with proper chunking (all under 300 lines):

- Main script: 56 lines
- Node.js wrapper: 158 lines  
- Configuration: 34 lines
- Libraries: 18-149 lines each
- Documentation: 33-165 lines each

## Ready to Use

### Basic Usage
```bash
/pr-reviewer https://github.com/owner/repo/pull/123
```

### Multiple PRs
```bash
/pr-reviewer https://github.com/owner/repo/pull/123|https://github.com/owner/repo/pull/124
```

Note: Use pipe `|` to separate multiple PR URLs.

### With Options
```bash
/pr-reviewer --focus security --context "Auth Feature" https://github.com/owner/repo/pull/123
```

## Prerequisites

Install GitHub CLI before first use:
```bash
# Install gh CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Authenticate
gh auth login
```

## Test Setup
```bash
.claude/skills/pr-reviewer/test.sh
```

## What You'll Get

When you provide PR URLs, Claude will:
1. Fetch PR metadata and diffs
2. Analyze code quality, security, testing, architecture
3. Identify cross-PR dependencies
4. **Infer task list** - what the developer accomplished
5. Provide prioritized findings (Critical/High/Medium/Low)
6. Give actionable recommendations

## Next Steps

1. Install `gh` CLI (see above)
2. Provide PR URLs when developers give you review tasks
3. Use `/pr-reviewer <URLs>` to trigger analysis

The skill is ready for your IT Manager daily tasks!
