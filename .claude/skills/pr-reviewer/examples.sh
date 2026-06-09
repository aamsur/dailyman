#!/usr/bin/env bash
# Example usage of PR Reviewer skill

echo "PR Reviewer - Usage Examples"
echo "============================"
echo ""

echo "1. Single PR Review:"
echo "   .claude/skills/pr-reviewer/pr-reviewer.sh https://github.com/owner/repo/pull/123"
echo ""

echo "2. Multiple PRs:"
echo "   .claude/skills/pr-reviewer/pr-reviewer.sh https://github.com/owner/repo/pull/123|https://github.com/owner/repo/pull/124"
echo ""

echo "3. Security Focus:"
echo "   .claude/skills/pr-reviewer/pr-reviewer.sh --focus security https://github.com/owner/repo/pull/123"
echo ""

echo "4. With Context:"
echo "   .claude/skills/pr-reviewer/pr-reviewer.sh --context 'Payment Integration' https://github.com/owner/repo/pull/123"
echo ""

echo "5. JSON Output:"
echo "   .claude/skills/pr-reviewer/pr-reviewer.sh --output json https://github.com/owner/repo/pull/123 > review.json"
echo ""
