---
skill: pr-reviewer
description: Review multiple related Git pull requests for a single task
tags: [git, pr, review, management]
---

# PR Reviewer Skill

Reviews multiple related pull requests that belong to a single task or feature.

## Usage

```bash
# Review single PR
pr-reviewer https://github.com/org/repo/pull/123

# Review multiple related PRs (use pipe separator)
pr-reviewer https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/124

# Review with specific focus
pr-reviewer --focus security https://github.com/org/repo/pull/123

# Review with custom context
pr-reviewer --context "Feature: User Authentication" https://github.com/org/repo/pull/123
```

## Arguments

- `pr_urls`: One or more PR URLs separated by pipe `|` (GitHub, GitLab, Bitbucket supported)
- `--focus`: Focus area (security, performance, architecture, testing, documentation)
- `--context`: Additional context about the task or feature
- `--output`: Output format (markdown, json, summary)

## What It Reviews

1. **Code Quality**
   - Code structure and organization
   - Naming conventions
   - Code duplication
   - Complexity analysis

2. **Security**
   - Authentication/authorization issues
   - Input validation
   - SQL injection risks
   - XSS vulnerabilities
   - Sensitive data exposure

3. **Testing**
   - Test coverage
   - Test quality
   - Edge cases
   - Integration tests

4. **Architecture**
   - Design patterns
   - Separation of concerns
   - Dependency management
   - API design

5. **Documentation**
   - Code comments
   - API documentation
   - README updates
   - Migration guides

6. **Performance**
   - Database queries
   - N+1 problems
   - Caching opportunities
   - Algorithm efficiency

## Review Process

1. Fetch PR metadata (title, description, author, labels)
2. Get diff and changed files
3. Analyze code changes across all PRs
4. Check for cross-PR dependencies
5. Identify potential conflicts
6. Review against best practices
7. Generate consolidated report

## Output Format

### Summary
- Overall assessment (approve/request changes/needs discussion)
- Key findings count
- Risk level (low/medium/high/critical)

### Findings
Each finding includes:
- Severity (critical/high/medium/low/info)
- Category (security/performance/architecture/etc)
- Location (file:line)
- Description
- Recommendation
- Code snippet (if applicable)

### Cross-PR Analysis
- Dependency chains
- Potential conflicts
- Integration concerns
- Testing recommendations

### Task List
- Inferred developer tasks based on PR changes
- What was accomplished in each PR
- Work breakdown from code analysis

## Integration

Works with:
- GitHub (via gh CLI)
- GitLab (via glab CLI)
- Bitbucket (via API)
- Generic git repositories

## Examples

### Example 1: Security-focused review
```bash
pr-reviewer --focus security \
  https://github.com/company/api/pull/456|https://github.com/company/web/pull/789
```
```

### Example 2: Related microservice PRs
```bash
pr-reviewer --context "Payment Integration Feature" \
  https://github.com/company/payment-service/pull/12|https://github.com/company/order-service/pull/34|https://github.com/company/notification-service/pull/56
```

### Example 3: JSON output for automation
```bash
pr-reviewer --output json https://github.com/company/repo/pull/123 > review.json
```

## Configuration

Create `.claude/pr-reviewer.json`:

```json
{
  "defaultFocus": ["security", "testing"],
  "autoFetchRelated": true,
  "requireTests": true,
  "securityRules": {
    "blockSecretsInCode": true,
    "requireInputValidation": true,
    "checkDependencyVulnerabilities": true
  },
  "reviewTemplate": "standard",
  "outputFormat": "markdown",
  "integrations": {
    "github": {
      "autoComment": false,
      "labelOnIssues": true
    }
  }
}
```

## Notes

- Requires appropriate CLI tools (gh, glab, etc) installed
- Needs authentication for private repositories
- Can handle up to 10 PRs in a single review session
- Supports cross-repository reviews within same organization
