#!/usr/bin/env bash
# Fetcher functions for PR Reviewer

# Source GitHub links helper
SCRIPT_DIR="${SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "${SCRIPT_DIR}/lib/github_links.sh"

# Fetch PR metadata using appropriate CLI
fetch_pr_metadata() {
    local url="$1"
    local platform="$2"
    local pr_dir="$3"

    log_info "Fetching PR metadata from $platform..."

    case "$platform" in
        github)
            local parsed=$(parse_pr_url "$url" "$platform")
            local repo=$(echo "$parsed" | cut -d' ' -f1)
            local pr_num=$(echo "$parsed" | cut -d' ' -f2)

            if ! command -v gh &> /dev/null; then
                log_error "gh CLI not found. Install from: https://cli.github.com"
                return 1
            fi

            gh pr view "$pr_num" --repo "$repo" --json title,body,author,state,labels,files,additions,deletions,changedFiles,headRefOid > "$pr_dir/metadata.json"
            gh pr diff "$pr_num" --repo "$repo" > "$pr_dir/diff.patch"

            # Store repo info for GitHub link generation
            echo "$repo" > "$pr_dir/repo.txt"
            echo "$pr_num" > "$pr_dir/pr_num.txt"

            # Extract commit SHA from metadata
            local commit_sha=$(jq -r '.headRefOid // "HEAD"' "$pr_dir/metadata.json" 2>/dev/null || echo "HEAD")
            echo "$commit_sha" > "$pr_dir/commit_sha.txt"

            log_success "Fetched GitHub PR #$pr_num from $repo"
            ;;

        gitlab)
            local parsed=$(parse_pr_url "$url" "$platform")
            local repo=$(echo "$parsed" | cut -d' ' -f1)
            local mr_num=$(echo "$parsed" | cut -d' ' -f2)

            if ! command -v glab &> /dev/null; then
                log_error "glab CLI not found. Install from: https://gitlab.com/gitlab-org/cli"
                return 1
            fi

            glab mr view "$mr_num" --repo "$repo" > "$pr_dir/metadata.txt"
            glab mr diff "$mr_num" --repo "$repo" > "$pr_dir/diff.patch"

            log_success "Fetched GitLab MR !$mr_num from $repo"
            ;;

        *)
            log_error "Unsupported platform: $platform"
            return 1
            ;;
    esac
}

# Fetch all PRs
fetch_all_prs() {
    mkdir -p "$TEMP_DIR"

    local pr_index=0
    for url in "${PR_URLS[@]}"; do
        local platform=$(detect_platform "$url")
        local pr_dir="$TEMP_DIR/pr_$pr_index"

        mkdir -p "$pr_dir"
        echo "$url" > "$pr_dir/url.txt"
        echo "$platform" > "$pr_dir/platform.txt"

        if ! fetch_pr_metadata "$url" "$platform" "$pr_dir"; then
            log_error "Failed to fetch PR: $url"
            return 1
        fi

        ((pr_index++))
    done

    log_success "Fetched all ${#PR_URLS[@]} PRs"
}
