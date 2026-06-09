#!/usr/bin/env bash
# Quick test for PR Reviewer skill

echo "Testing PR Reviewer Skill Setup..."
echo ""

# Check if skill directory exists
if [[ -d ".claude/skills/pr-reviewer" ]]; then
    echo "✓ Skill directory exists"
else
    echo "✗ Skill directory missing"
    exit 1
fi

# Check if main script exists
if [[ -f ".claude/skills/pr-reviewer/pr-reviewer.sh" ]]; then
    echo "✓ Main script exists"
else
    echo "✗ Main script missing"
    exit 1
fi

# Check if lib files exist
for lib in logging parser fetcher prompt; do
    if [[ -f ".claude/skills/pr-reviewer/lib/${lib}.sh" ]]; then
        echo "✓ Library ${lib}.sh exists"
    else
        echo "✗ Library ${lib}.sh missing"
        exit 1
    fi
done

# Check if config exists
if [[ -f ".claude/pr-reviewer.json" ]]; then
    echo "✓ Configuration file exists"
else
    echo "✗ Configuration file missing"
    exit 1
fi

# Check for required CLI tools
echo ""
echo "Checking CLI tools:"

if command -v gh &> /dev/null; then
    echo "✓ gh (GitHub CLI) installed: $(gh --version | head -n1)"
else
    echo "✗ gh (GitHub CLI) not found - Install from: https://cli.github.com"
fi

if command -v glab &> /dev/null; then
    echo "✓ glab (GitLab CLI) installed: $(glab --version)"
else
    echo "⚠ glab (GitLab CLI) not found - Only needed for GitLab MRs"
fi

echo ""
echo "Setup validation complete!"
