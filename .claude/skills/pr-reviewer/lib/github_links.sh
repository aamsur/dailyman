#!/usr/bin/env bash
# GitHub link generation functions for PR Reviewer

# Extract commit SHA from PR metadata
get_pr_commit_sha() {
    local pr_dir="$1"
    local metadata_file="$pr_dir/metadata.json"

    if [[ -f "$metadata_file" ]]; then
        # Get the head commit SHA from PR metadata
        jq -r '.headRefOid // .commits[-1].oid // "HEAD"' "$metadata_file" 2>/dev/null || echo "HEAD"
    else
        echo "HEAD"
    fi
}

# Extract repo info from PR URL
get_repo_info_from_url() {
    local url="$1"

    if [[ "$url" =~ github\.com/([^/]+)/([^/]+)/pull/([0-9]+) ]]; then
        local owner="${BASH_REMATCH[1]}"
        local repo="${BASH_REMATCH[2]}"
        local pr_num="${BASH_REMATCH[3]}"

        echo "$owner $repo $pr_num"
    else
        echo ""
    fi
}

# Generate GitHub permalink for a file with line highlighting
# Usage: generate_github_link "owner/repo" "commit_sha" "path/to/file.py" "123" "145"
generate_github_link() {
    local repo="$1"
    local commit_sha="$2"
    local file_path="$3"
    local start_line="$4"
    local end_line="${5:-$start_line}"

    # Remove leading slash if present
    file_path="${file_path#/}"

    local base_url="https://github.com/${repo}/blob/${commit_sha}/${file_path}"

    if [[ -n "$start_line" ]]; then
        if [[ "$start_line" == "$end_line" ]]; then
            echo "${base_url}#L${start_line}"
        else
            echo "${base_url}#L${start_line}-L${end_line}"
        fi
    else
        echo "$base_url"
    fi
}

# Store PR metadata for link generation
store_pr_metadata_for_links() {
    local pr_index="$1"
    local url="$2"
    local pr_dir="$TEMP_DIR/pr_$pr_index"

    local repo_info=$(get_repo_info_from_url "$url")
    if [[ -n "$repo_info" ]]; then
        local owner=$(echo "$repo_info" | cut -d' ' -f1)
        local repo=$(echo "$repo_info" | cut -d' ' -f2)
        local pr_num=$(echo "$repo_info" | cut -d' ' -f3)

        echo "${owner}/${repo}" > "$pr_dir/repo.txt"
        echo "$pr_num" > "$pr_dir/pr_num.txt"

        # Get commit SHA
        local commit_sha=$(get_pr_commit_sha "$pr_dir")
        echo "$commit_sha" > "$pr_dir/commit_sha.txt"
    fi
}
