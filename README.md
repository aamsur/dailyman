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

**📖 [Read full documentation →](.claude/skills/pr-reviewer/README.md)**

## Installation

Clone this repository to your workspace:

```bash
cd ~/workspace
git clone https://github.com/aamsur/dailyman.git
cd dailyman
```

Skills will be automatically available in Claude Code.

## Quick Start

### PR Reviewer

Review single or multiple PRs with helicopter view:

```bash
# Single PR
/pr-reviewer https://github.com/org/repo/pull/123

# Multiple PRs across repositories
/pr-reviewer https://github.com/org/api/pull/123|https://github.com/org/frontend/pull/456

# Focused review
/pr-reviewer --focus security https://github.com/org/repo/pull/123
```

**For detailed usage and setup**, see [PR Reviewer Documentation](.claude/skills/pr-reviewer/README.md)

## Project Structure

```
dailyman/
├── .claude/
│   ├── skills/
│   │   └── pr-reviewer/       # PR review skill
│   │       ├── README.md      # Full documentation
│   │       ├── QUICKSTART.md  # Setup guide
│   │       └── ...            # Implementation
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
- **Issues**: [GitHub Issues](https://github.com/aamsur/dailyman/issues)
- **Discussions**: [GitHub Discussions](https://github.com/aamsur/dailyman/discussions)

## Credits

Built with ❤️ for IT Managers and Tech Leads using [Claude Code](https://claude.ai/code)

---
