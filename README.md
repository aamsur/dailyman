# Daily Manager - Claude Code Skills for IT Managers

A collection of productivity skills for Claude Code designed to streamline daily tasks for IT Managers and Tech Leads.

## Overview

**Daily Manager** provides intelligent automation tools that help IT leaders efficiently manage code reviews, team workflows, and development processes through Claude Code's AI-powered interface.

## Features

### 🔍 PR Reviewer Skill

Comprehensive multi-PR review tool that analyzes pull requests across security, architecture, testing, and code quality dimensions.

**Key Capabilities:**
- **Multi-PR Analysis** - Review multiple related PRs simultaneously
- **Security Scanning** - Detect auth issues, SQL injection, XSS, hardcoded secrets
- **Architecture Review** - Identify design patterns, coupling, and maintainability concerns
- **Testing Coverage** - Verify test completeness and quality
- **Task Inference** - Automatically extract what developers accomplished
- **Cross-PR Dependencies** - Detect conflicts and dependencies between PRs
- **Prioritized Findings** - Critical/High/Medium/Low severity classification

## Installation

### Prerequisites

1. **Claude Code** - Install from [claude.ai/code](https://claude.ai/code)
2. **GitHub CLI** - Required for PR fetching

```bash
# Install GitHub CLI (Ubuntu/Debian)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Authenticate with GitHub
gh auth login
```

### Setup

1. Clone this repository to your Claude Code skills directory:

```bash
# Clone to your Claude workspace
cd ~/workspace
git clone https://github.com/YOUR_USERNAME/dailyman.git
cd dailyman
```

2. The skills will be automatically available in Claude Code.

## Usage

### PR Reviewer

#### Single PR Review
```bash
/pr-reviewer https://github.com/org/repo/pull/123
```

#### Multiple PRs (use pipe separator)
```bash
/pr-reviewer https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/124
```

#### Focused Review
```bash
# Focus on specific area
/pr-reviewer --focus security https://github.com/org/repo/pull/123

# Add context
/pr-reviewer --context "Payment Gateway Integration" https://github.com/org/repo/pull/123
```

### Review Output

Claude will provide:

1. **Executive Summary** - Overall assessment (APPROVE/REQUEST CHANGES/NEEDS DISCUSSION)
2. **Risk Level** - LOW/MEDIUM/HIGH/CRITICAL
3. **Critical Findings** - Must fix before merge
4. **High Priority** - Should fix soon
5. **Medium Priority** - Nice to have improvements
6. **Low Priority** - Suggestions and style improvements
7. **Cross-PR Analysis** - Dependencies and conflicts
8. **Task List** - What the developer accomplished
9. **Recommendations** - Next steps and follow-up actions

## Configuration

### Default Settings

The PR reviewer comes with sensible defaults in `.claude/pr-reviewer.json`:

```json
{
  "defaultFocus": ["security", "testing", "architecture"],
  "securityRules": {
    "blockSecretsInCode": true,
    "requireInputValidation": true,
    "checkDependencyVulnerabilities": true,
    "checkAuthenticationPatterns": true
  }
}
```

### Custom Configuration

Create `.claude/settings.local.json` for personal preferences (automatically ignored by git).

## Use Cases

### For IT Managers
- **Daily PR Reviews** - Quickly review team's pull requests
- **Security Audits** - Catch security issues before they reach production
- **Architecture Oversight** - Ensure design consistency across features
- **Knowledge Transfer** - Understand what teams are building

### For Tech Leads
- **Code Quality Gates** - Enforce standards before merge
- **Mentoring** - Generate detailed feedback for junior developers
- **Technical Debt** - Identify areas needing refactoring
- **Cross-Team Reviews** - Review PRs from multiple teams efficiently

## Project Structure

```
dailyman/
├── .claude/
│   ├── skills/
│   │   └── pr-reviewer/       # PR review skill implementation
│   │       ├── pr-reviewer.sh # Main orchestration script
│   │       ├── pr-reviewer.js # Node.js wrapper
│   │       └── lib/           # Helper libraries
│   └── pr-reviewer.json       # Configuration
├── CLAUDE.MD                  # Skill registration
├── README.md                  # This file
├── LICENSE                    # MIT License
└── .gitignore                 # Git exclusions
```

## Security & Privacy

✅ **No credentials stored** - Uses your GitHub CLI authentication  
✅ **No data collection** - Everything runs locally  
✅ **Open source** - Review the code yourself  
✅ **Private by default** - Your settings stay local  

See [SECURITY_ASSESSMENT.md](SECURITY_ASSESSMENT.md) for detailed security analysis.

## Requirements

- **Claude Code** - Latest version recommended
- **GitHub CLI (gh)** - v2.0.0 or higher
- **Bash** - v4.0 or higher
- **Node.js** - v14 or higher (for advanced features)
- **Git** - Any recent version

## Troubleshooting

### PR Reviewer Not Working

1. **Check GitHub CLI authentication:**
```bash
gh auth status
```

2. **Test skill directly:**
```bash
.claude/skills/pr-reviewer/test.sh
```

3. **Verify permissions:**
```bash
chmod +x .claude/skills/pr-reviewer/pr-reviewer.sh
```

### Permission Denied

Ensure scripts are executable:
```bash
find .claude/skills -name "*.sh" -exec chmod +x {} \;
```

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-skill`)
3. Commit your changes (`git commit -m 'Add amazing skill'`)
4. Push to the branch (`git push origin feature/amazing-skill`)
5. Open a Pull Request

## Roadmap

- [ ] Jira integration for ticket linking
- [ ] Slack notifications for review completion
- [ ] GitLab support
- [ ] Custom review templates
- [ ] Team metrics and analytics

## License

MIT License - see [LICENSE](LICENSE) file for details

## Credits

Built with ❤️ for IT Managers and Tech Leads using [Claude Code](https://claude.ai/code)

## Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/dailyman/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/dailyman/discussions)
- **Documentation**: See `.claude/skills/pr-reviewer/QUICKSTART.md`

---

**Note**: Replace `YOUR_USERNAME` with your actual GitHub username after publishing.
