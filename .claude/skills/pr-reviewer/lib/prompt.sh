#!/usr/bin/env bash
# Prompt generation functions for PR Reviewer

# Source table format template
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "${SCRIPT_DIR}/lib/prompt_table_format.sh"

# Generate Claude prompt for review
generate_review_prompt() {
    local prompt_file="$TEMP_DIR/review_prompt.txt"

    # Write header
    cat > "$prompt_file" << 'EOF'
# PR Review Request

I need you to review the following pull request(s). Please provide a comprehensive analysis.

**IMPORTANT**: Focus your review ONLY on the changes shown in the diff. Do not analyze or make assumptions about code outside the changes. Do not suggest checking other files in the repository unless directly related to the changes.

EOF

    # Add context if provided
    if [[ -n "$CONTEXT" ]]; then
        cat >> "$prompt_file" << EOF

## Context
$CONTEXT

EOF
    fi

    # Add focus area if provided
    if [[ -n "$FOCUS" ]]; then
        cat >> "$prompt_file" << EOF

## Focus Area
Please pay special attention to: $FOCUS

EOF
    fi

    # Write review criteria
    cat >> "$prompt_file" << 'EOF'

## Review Criteria

Analyze ONLY the changed code in the diff for:

1. **Code Quality** (in changed lines only)
   - Structure and organization of new/modified code
   - Naming conventions in new variables/functions
   - Code duplication within the changes
   - Complexity of new logic

2. **Security** (in changed lines only)
   - New authentication/authorization logic
   - Input validation on new parameters
   - SQL injection risks in new queries
   - XSS vulnerabilities in new outputs
   - Sensitive data handling in new code

3. **Testing**
   - Test files added/modified for these changes
   - Test coverage for new functionality
   - Edge cases for new logic

4. **Architecture** (in changed code only)
   - Design patterns in new code
   - How changes fit with existing patterns visible in diff context
   - API design changes

5. **Performance** (in changed code only)
   - New database queries
   - New loops or algorithms
   - Obvious performance issues in new code

6. **Documentation**
   - Comments added/modified
   - Documentation for new APIs

**CONSTRAINTS:**
- Do NOT read other files not shown in the diff
- Do NOT make assumptions about code outside the changes
- Do NOT suggest "check the repository" or "verify in other files"
- Base your review ONLY on what is visible in the PR diff

EOF

    # Add PR details
    add_pr_details_to_prompt "$prompt_file"

    # Write output format instructions (table-based)
    generate_table_format_prompt "$prompt_file"

    echo "$prompt_file"
}

# Add PR details to prompt (separate function to keep under 300 lines)
add_pr_details_to_prompt() {
    local prompt_file="$1"
    local pr_index=0

    for url in "${PR_URLS[@]}"; do
        local pr_dir="$TEMP_DIR/pr_$pr_index"

        # Read GitHub metadata for link generation
        local repo=""
        local commit_sha=""
        if [[ -f "$pr_dir/repo.txt" ]]; then
            repo=$(cat "$pr_dir/repo.txt")
        fi
        if [[ -f "$pr_dir/commit_sha.txt" ]]; then
            commit_sha=$(cat "$pr_dir/commit_sha.txt")
        fi

        cat >> "$prompt_file" << EOF

---

## PR #$((pr_index + 1)): $url

### PR Link Context
Repository: $repo
Commit SHA: $commit_sha

### Metadata
$(cat "$pr_dir/metadata.json" 2>/dev/null || cat "$pr_dir/metadata.txt" 2>/dev/null)

### Diff
\`\`\`diff
$(head -n 500 "$pr_dir/diff.patch")
\`\`\`

EOF
        ((pr_index++))
    done
}
