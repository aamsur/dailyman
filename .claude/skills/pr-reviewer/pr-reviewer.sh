#!/usr/bin/env bash
# PR Reviewer Skill - Implementation Script
# Handles multiple related PRs for comprehensive review

set -euo pipefail

# Constants
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/../pr-reviewer.json"
TEMP_DIR="/tmp/pr-reviewer-$$"
MAX_PRS=10

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Source helper functions
source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/parser.sh"
source "${SCRIPT_DIR}/lib/fetcher.sh"
source "${SCRIPT_DIR}/lib/prompt.sh"

# Cleanup on exit
cleanup() {
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
    fi
}
trap cleanup EXIT

# Main execution
main() {
    parse_args "$@"

    log_info "Starting PR review for ${#PR_URLS[@]} PR(s)..."

    # Fetch all PRs
    if ! fetch_all_prs; then
        log_error "Failed to fetch PRs"
        exit 1
    fi

    # Generate review prompt
    local prompt_file=$(generate_review_prompt)

    log_info "Review prompt generated at: $prompt_file"
    log_info "PR data stored in: $TEMP_DIR"

    # Output the prompt for Claude to process
    cat "$prompt_file"
}

main "$@"
