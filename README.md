# Daily Manager - Claude Code Skills for IT Managers

A collection of productivity skills for Claude Code designed to streamline daily tasks for IT Managers and Tech Leads.

## Overview

**Daily Manager** provides intelligent automation tools that help IT leaders efficiently manage code reviews, team workflows, and development processes through Claude Code's AI-powered interface.

## Prerequisites

- **Claude Code** - Available as CLI, desktop app, web app, or IDE extensions
- See individual skill documentation for specific requirements

## Features

### 🔍 PR Reviewer Skill

Comprehensive multi-PR review tool that provides a **helicopter view** of your team's work. Designed for IT Managers and Tech Leads who need to review multiple PRs from different repositories and understand the **big picture** of how changes interconnect.

#### Helicopter View Capabilities

Instead of reviewing PRs in isolation, PR Reviewer analyzes multiple pull requests simultaneously across different repositories, giving you strategic oversight:

- **See Cross-Repository Relationships** - Understand how a frontend PR relates to backend API changes
- **Track Feature Implementation** - Review all PRs involved in a single feature across microservices
- **Identify Integration Risks** - Spot conflicts or dependencies between PRs from different repos
- **Understand Business Context** - Automatically infer the complete task/feature being delivered
- **Strategic Decision Making** - Make informed decisions based on the full scope of changes

**Example**: A developer submits 3 PRs - one for the API service, one for the frontend, and one for database migrations. PR Reviewer analyzes all three together, showing you how they connect, what could break, and whether the implementation is complete.

#### Key Capabilities

- **Multi-Repository PR Analysis** - Review PRs from different repos simultaneously
- **Cross-PR Impact Analysis** - Understand how changes in one repo affect others
- **Security Scanning** - Detect auth issues, SQL injection, XSS, hardcoded secrets
- **Architecture Review** - Identify design patterns, coupling, and maintainability concerns
- **Testing Coverage** - Verify test completeness and quality across all PRs
- **Task Inference** - Automatically extract what developers accomplished across repos
- **Dependency Detection** - Spot integration points and breaking changes
- **Prioritized Findings** - Critical/High/Medium/Low severity classification

#### Review Output

When you review PRs, you'll receive:

1. **Executive Summary** - Overall assessment (APPROVE/REQUEST CHANGES/NEEDS DISCUSSION)
2. **Risk Level** - LOW/MEDIUM/HIGH/CRITICAL
3. **Critical Findings** - Must fix before merge
4. **High Priority** - Should fix soon
5. **Medium Priority** - Nice to have improvements
6. **Low Priority** - Suggestions and style improvements
7. **Cross-PR Analysis** - Dependencies and conflicts between PRs
8. **Task List** - What the developer accomplished across all changes
9. **Recommendations** - Next steps and follow-up actions

## Installation

Clone this repository to your workspace:

```bash
cd ~/workspace
git clone https://github.com/YOUR_USERNAME/dailyman.git
cd dailyman
```

Skills will be automatically available in Claude Code.

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

#### Cross-Repository Review
```bash
/pr-reviewer https://github.com/org/api/pull/123|https://github.com/org/frontend/pull/456|https://github.com/org/db/pull/789
```

#### Focused Review
```bash
# Focus on specific area
/pr-reviewer --focus security https://github.com/org/repo/pull/123

# Add business context
/pr-reviewer --context "Payment Gateway Integration" https://github.com/org/repo/pull/123
```

**For detailed setup and requirements**, see [.claude/skills/pr-reviewer/QUICKSTART.md](.claude/skills/pr-reviewer/QUICKSTART.md)

## Use Cases

### For IT Managers

- **Daily PR Reviews** - Quickly review team's pull requests with helicopter view
- **Security Audits** - Catch security issues before they reach production
- **Architecture Oversight** - Ensure design consistency across microservices
- **Knowledge Transfer** - Understand what teams are building across repos
- **Cross-Team Coordination** - Review PRs from multiple teams and spot integration issues

### For Tech Leads

- **Code Quality Gates** - Enforce standards before merge
- **Mentoring** - Generate detailed feedback for junior developers
- **Technical Debt** - Identify areas needing refactoring across services
- **Feature Delivery** - Verify complete feature implementation across repos
- **Integration Testing** - Ensure changes work together before deployment

## Configuration

### Default Settings

PR reviewer comes with sensible defaults in `.claude/pr-reviewer.json`:

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

See individual skill documentation for detailed configuration options.

## Project Structure

```
dailyman/
├── .claude/
│   ├── skills/
│   │   └── pr-reviewer/       # PR review skill
│   │       ├── QUICKSTART.md  # Setup guide
│   │       ├── pr-reviewer.sh # Main script
│   │       └── lib/           # Helper libraries
│   └── pr-reviewer.json       # Configuration
├── CLAUDE.MD                  # Skill registration
├── README.md                  # This file
├── LICENSE                    # MIT License
└── .gitignore                 # Git exclusions
```

## Security & Privacy

✅ **No credentials stored** - Uses your own authentication  
✅ **No data collection** - Everything runs locally  
✅ **Open source** - Review the code yourself  
✅ **Private by default** - Your settings stay local  

See [SECURITY_ASSESSMENT.md](SECURITY_ASSESSMENT.md) for detailed security analysis.

## Roadmap

Future skills and features planned:

- [ ] Jira integration for ticket linking
- [ ] Slack notifications for review completion
- [ ] GitLab support
- [ ] Custom review templates
- [ ] Team metrics and analytics
- [ ] Sprint planning assistant
- [ ] Incident response helper

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-skill`)
3. Commit your changes (`git commit -m 'Add new skill'`)
4. Push to the branch (`git push origin feature/new-skill`)
5. Open a Pull Request

## License

MIT License - see [LICENSE](LICENSE) file for details

## Support

- **Documentation**: See individual skill directories for detailed guides
- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/dailyman/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/dailyman/discussions)

## Credits

Built with ❤️ for IT Managers and Tech Leads using [Claude Code](https://claude.ai/code)

---

**Note**: Replace `YOUR_USERNAME` with your actual GitHub username after publishing.
