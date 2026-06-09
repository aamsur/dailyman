# PR Reviewer Skill - Ready to Use!

## ✅ Installation Complete

The PR Reviewer skill is now installed and ready to use in Claude CLI and VS Code.

## How to Use

### In Claude CLI or VS Code

Simply type:
```
/pr-reviewer https://github.com/org/repo/pull/123
```

### Multiple PRs (use pipe separator)
```
/pr-reviewer https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/124
```

### With Options
```
/pr-reviewer --focus security https://github.com/org/repo/pull/123
/pr-reviewer --context "Payment Feature" https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/456
```

## What You'll Get

Claude will analyze the PRs and provide:

1. **Executive Summary**
   - Overall assessment (APPROVE/REQUEST CHANGES/NEEDS DISCUSSION)
   - Risk level (LOW/MEDIUM/HIGH/CRITICAL)
   - Key findings count

2. **Critical Findings** - Must fix
3. **High Priority Findings** - Should fix
4. **Medium Priority Findings** - Nice to have
5. **Low Priority** - Suggestions
6. **Cross-PR Analysis** - Dependencies, conflicts
7. **Task List** - What developer accomplished (NEW!)
8. **Recommendations** - Next steps

## Requirements Met

✅ gh CLI installed and authenticated
✅ Skill files created and configured
✅ All scripts executable
✅ Documentation complete

## Test It Now!

Try it with a real PR:
```
/pr-reviewer <paste-your-PR-URL-here>
```

The skill will fetch the PR, analyze it, and provide comprehensive review!
