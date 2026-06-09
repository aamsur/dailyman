#!/usr/bin/env bash
# Parser functions for PR Reviewer

# Parse command line arguments
parse_args() {
    PR_URLS=()
    FOCUS=""
    CONTEXT=""
    OUTPUT_FORMAT="markdown"

    # First, split all args by pipe separator
    local all_args="$*"

    while [[ $# -gt 0 ]]; do
        case $1 in
            --focus)
                FOCUS="$2"
                shift 2
                ;;
            --context)
                CONTEXT="$2"
                shift 2
                ;;
            --output)
                OUTPUT_FORMAT="$2"
                shift 2
                ;;
            *|*)
                # Contains pipe - split into multiple URLs
                IFS='|' read -ra URLS <<< "$1"
                for url in "${URLS[@]}"; do
                    url=$(echo "$url" | xargs) # trim whitespace
                    if [[ "$url" =~ http ]]; then
                        PR_URLS+=("$url")
                    fi
                done
                shift
                ;;
            http*://*)
                PR_URLS+=("$1")
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    if [[ ${#PR_URLS[@]} -eq 0 ]]; then
        log_error "No PR URLs provided"
        echo "Usage: pr-reviewer [--focus AREA] [--context TEXT] [--output FORMAT] PR_URL[|PR_URL...]" >&2
        echo "Example: pr-reviewer https://github.com/org/repo/pull/123|https://github.com/org/repo/pull/124" >&2
        exit 1
    fi

    if [[ ${#PR_URLS[@]} -gt $MAX_PRS ]]; then
        log_error "Maximum $MAX_PRS PRs allowed, got ${#PR_URLS[@]}"
        exit 1
    fi
}

# Detect PR platform (GitHub, GitLab, Bitbucket)
detect_platform() {
    local url="$1"

    if [[ "$url" =~ github\.com ]]; then
        echo "github"
    elif [[ "$url" =~ gitlab\.com ]]; then
        echo "gitlab"
    elif [[ "$url" =~ bitbucket\.org ]]; then
        echo "bitbucket"
    else
        echo "unknown"
    fi
}

# Extract PR number and repo from URL
parse_pr_url() {
    local url="$1"
    local platform="$2"

    case "$platform" in
        github)
            # https://github.com/owner/repo/pull/123
            echo "$url" | sed -E 's|https://github\.com/([^/]+)/([^/]+)/pull/([0-9]+).*|\1/\2 \3|'
            ;;
        gitlab)
            # https://gitlab.com/owner/repo/-/merge_requests/123
            echo "$url" | sed -E 's|https://gitlab\.com/([^/]+)/([^/]+)/-/merge_requests/([0-9]+).*|\1/\2 \3|'
            ;;
        *)
            echo ""
            ;;
    esac
}
