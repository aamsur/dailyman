#!/usr/bin/env bash
# Table-formatted output prompt template for PR Reviewer

# Generate table-formatted review prompt
generate_table_format_prompt() {
    local prompt_file="$1"

    cat >> "$prompt_file" << 'EOF'

---

## Output Format

Please provide your review in a well-formatted, table-based structure for better readability.

### 1. Executive Summary Table

| Aspect | Value |
|--------|-------|
| **Assessment** | APPROVE / REQUEST CHANGES / NEEDS DISCUSSION |
| **Risk Level** | 🟢 LOW / 🟡 MEDIUM / 🟠 HIGH / 🔴 CRITICAL |
| **Critical Issues** | [count] |
| **High Priority** | [count] |
| **Medium Priority** | [count] |
| **Low Priority** | [count] |
| **Files Changed** | [count] |
| **Lines Added** | [count] |
| **Lines Removed** | [count] |

---

### 2. Findings Summary Table

| Priority | Category | Issue | Location | Impact | Recommendation |
|----------|----------|-------|----------|--------|----------------|
| 🔴 CRITICAL | Security | [Brief description] | [file.py:123-145](https://github.com/{repo}/blob/{sha}/file.py#L123-L145) | [Impact description] | [Action needed] |
| 🔴 CRITICAL | Bug | [Brief description] | [file.py:200](https://github.com/{repo}/blob/{sha}/file.py#L200) | [Impact description] | [Action needed] |
| 🟠 HIGH | Code Quality | [Brief description] | [file.py:300-350](https://github.com/{repo}/blob/{sha}/file.py#L300-L350) | [Impact description] | [Action needed] |
| 🟡 MEDIUM | Performance | [Brief description] | [file.py:400](https://github.com/{repo}/blob/{sha}/file.py#L400) | [Impact description] | [Action needed] |
| 🟢 LOW | Style | [Brief description] | [file.py:500](https://github.com/{repo}/blob/{sha}/file.py#L500) | [Impact description] | [Action needed] |

**Priority Icons:**
- 🔴 CRITICAL: Must fix before merge
- 🟠 HIGH: Should fix before merge
- 🟡 MEDIUM: Good to fix soon
- 🟢 LOW: Nice to have

**Category Icons:**
- 🔒 Security
- 🐛 Bug
- ⚡ Performance
- 🧹 Code Quality
- 📝 Documentation
- 🧪 Testing
- 🏗️ Architecture
- 💅 Style

---

### 3. Detailed Findings by Priority

For each finding, provide detailed analysis:

#### 🔴 Critical Findings

**[Finding #1 Title]**
- **File**: [apps/helpers/file.py:123-145](https://github.com/{repo}/blob/{sha}/apps/helpers/file.py#L123-L145)
- **Category**: 🔒 Security / 🐛 Bug / etc.
- **Issue**: [Detailed description of what's wrong]
- **Impact**: [What happens if not fixed]
- **Code Reference**:
  ```python
  # Problematic code snippet
  ```
- **Recommendation**: [Specific fix needed]
- **Why It Matters**: [Business/technical context]

[Repeat for each critical finding]

---

#### 🟠 High Priority Findings

[Same structure as Critical]

---

#### 🟡 Medium Priority Findings

[Same structure but more concise]

---

#### 🟢 Low Priority / Suggestions

[Brief bullet points acceptable here]

---

### 4. Task Accomplishment Table

| Task # | Category | Description | Files Affected | Status |
|--------|----------|-------------|----------------|--------|
| 1 | Feature | Added FPK number field to claims | `models/anp_claims.py`, `requests/anp_claim_req.py` | ✅ Complete |
| 2 | Enhancement | Updated PDF template with new section | `helpers/pyfpdf.py` | ⚠️ Incomplete |
| 3 | Refactor | Modified query logic for admin role | `repository/anp_claims_repository.py` | ✅ Complete |

**Status Icons:**
- ✅ Complete
- ⚠️ Incomplete / Issues found
- 🔄 In progress
- ❌ Failed / Broken

---

### 5. Cross-PR Analysis (if multiple PRs)

| PR | Dependencies | Conflicts | Integration Risk | Notes |
|----|--------------|-----------|------------------|-------|
| #398 | None | None | Low | Standalone feature |

---

### 6. Files Changed Summary Table

| File | Changes | Risk | Notes |
|------|---------|------|-------|
| [apps/helpers/pyfpdf.py](https://github.com/{repo}/blob/{sha}/apps/helpers/pyfpdf.py) | +407 / -23 | 🟠 HIGH | Large refactor, duplicate code |
| [apps/models/data/anp_claims.py](https://github.com/{repo}/blob/{sha}/apps/models/data/anp_claims.py) | +1 / -0 | 🟢 LOW | Simple field addition |
| [apps/repository/anp_claims_repository.py](https://github.com/{repo}/blob/{sha}/apps/repository/anp_claims_repository.py) | +46 / -2 | 🟡 MEDIUM | Query logic change |

---

### 7. Action Items Checklist

Present immediate action items:

- [ ] **BLOCKER**: Fix incomplete function implementation
- [ ] **BLOCKER**: Add null safety for string concatenation
- [ ] **REQUIRED**: Verify database migration exists
- [ ] **REQUIRED**: Add test coverage for new features
- [ ] **RECOMMENDED**: Refactor duplicate code
- [ ] **RECOMMENDED**: Add input validation
- [ ] **OPTIONAL**: Extract magic strings to constants

---

### 8. Review Summary & Recommendation

**Merge Recommendation**: [Clear yes/no with conditions]

**Estimated Fix Time**: [e.g., "2-4 hours"]

**Next Steps**:
1. [First priority action]
2. [Second priority action]
3. [Third priority action]

**Reviewer Notes**: [Any additional context]

---

**FORMATTING RULES:**
1. Use tables for all structured data
2. Use emoji indicators (🔴🟠🟡🟢) for visual scanning
3. Use code blocks with syntax highlighting
4. Keep file paths in `code format`
5. Use **bold** for critical items
6. Include line numbers in code references
7. Make tables align with consistent columns
8. **CRITICAL**: Convert all file location references to clickable GitHub links

**CLICKABLE LINKS RULE:**
For every file location reference (e.g., `file.py:123`, `file.py:123-145`), you MUST convert it to a clickable markdown link using this format:

- Single line: `[file.py:123](https://github.com/{Repository}/blob/{Commit SHA}/file.py#L123)`
- Line range: `[file.py:123-145](https://github.com/{Repository}/blob/{Commit SHA}/file.py#L123-L145)`

Use the Repository and Commit SHA provided in the "PR Link Context" section above.

**Examples:**
- Instead of: `workflow_repo.py:184`
- Write: `[workflow_repo.py:184](https://github.com/kodyland/unidev-workflow-api/blob/abc123/apps/repository/workflow_repo.py#L184)`

- Instead of: `file.py:123-145`
- Write: `[file.py:123-145](https://github.com/owner/repo/blob/abc123/path/to/file.py#L123-L145)`

Apply this to ALL location references in:
- Findings Summary Table (Location column)
- Detailed Findings (File field)
- Files Changed Summary Table (File column)
- Any other location references

**REMINDER**: All findings must reference specific lines/sections from the diff shown above.

EOF
}
