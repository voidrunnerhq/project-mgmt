#!/usr/bin/env sh

# VoidRunner Milestone Management Script

REPO_OWNER="voidrunnerhq"
REPO_NAME="voidrunner"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display milestone status
show_milestone_status() {
    echo -e "${BLUE}=== VoidRunner Milestone Status ===${NC}"
    gh api repos/$REPO_OWNER/$REPO_NAME/milestones | jq -r '.[] | 
        "Milestone: \(.title)
        Due: \(.due_on // "No due date")
        Progress: \(.closed_issues)/\((.open_issues + .closed_issues)) issues (\(if (.open_issues + .closed_issues) > 0 then ((.closed_issues * 100) / (.open_issues + .closed_issues) | floor) else 0 end)%)
        Status: \(.state)
        ---"'
}

# Function to show issues by milestone
show_milestone_issues() {
    local milestone_number=$1
    echo -e "${BLUE}=== Issues in Milestone $milestone_number ===${NC}"
    gh api repos/$REPO_OWNER/$REPO_NAME/issues?milestone=$milestone_number | jq -r '.[] | 
        "Issue #\(.number): \(.title)
        Status: \(.state)
        Assignee: \(.assignee.login // "Unassigned")
        Labels: \([.labels[].name] | join(", "))
        ---"'
}

# Function to check milestone health
check_milestone_health() {
    echo -e "${BLUE}=== Milestone Health Check ===${NC}"
    
    # Get current date in seconds
    current_date=$(date +%s)
    
    gh api repos/$REPO_OWNER/$REPO_NAME/milestones | jq -r '.[] | select(.state == "open") | 
        "\(.number)|\(.title)|\(.due_on)|\(.open_issues)|\(.closed_issues)"' | \
    while IFS='|' read -r number title due_date open_issues closed_issues; do
        total_issues=$((open_issues + closed_issues))
        
        if [ "$total_issues" -gt 0 ]; then
            completion_rate=$((closed_issues * 100 / total_issues))
        else
            completion_rate=0
        fi
        
        # Check if milestone is overdue
        if [ "$due_date" != "null" ]; then
            due_seconds=$(date -d "$due_date" +%s 2>/dev/null || echo "0")
            if [ "$due_seconds" -lt "$current_date" ]; then
                status_color=$RED
                status="OVERDUE"
            elif [ "$completion_rate" -lt 50 ]; then
                status_color=$YELLOW
                status="AT RISK"
            else
                status_color=$GREEN
                status="ON TRACK"
            fi
        else
            status_color=$YELLOW
            status="NO DUE DATE"
        fi
        
        echo -e "${status_color}$title: $completion_rate% complete - $status${NC}"
    done
}

# Function to create sprint report
generate_sprint_report() {
    local milestone_number=$1
    echo -e "${BLUE}=== Sprint Report for Milestone $milestone_number ===${NC}"
    
    # Get milestone details
    milestone_data=$(gh api repos/$REPO_OWNER/$REPO_NAME/milestones/$milestone_number)
    title=$(echo "$milestone_data" | jq -r '.title')
    due_date=$(echo "$milestone_data" | jq -r '.due_on // "No due date"')
    open_issues=$(echo "$milestone_data" | jq -r '.open_issues')
    closed_issues=$(echo "$milestone_data" | jq -r '.closed_issues')
    total_issues=$((open_issues + closed_issues))
    
    if [ "$total_issues" -gt 0 ]; then
        completion_rate=$((closed_issues * 100 / total_issues))
    else
        completion_rate=0
    fi
    
    echo "Milestone: $title"
    echo "Due Date: $due_date"
    echo "Progress: $closed_issues/$total_issues issues ($completion_rate%)"
    echo ""
    
    # Show completed issues this week
    echo -e "${GREEN}Completed Issues:${NC}"
    gh api repos/$REPO_OWNER/$REPO_NAME/issues?milestone=$milestone_number\&state=closed | \
        jq -r '.[] | select(.closed_at | fromdateiso8601 > (now - 604800)) | 
        "✓ Issue #\(.number): \(.title)"'
    
    echo ""
    
    # Show remaining open issues
    echo -e "${YELLOW}Remaining Issues:${NC}"
    gh api repos/$REPO_OWNER/$REPO_NAME/issues?milestone=$milestone_number\&state=open | \
        jq -r '.[] | "• Issue #\(.number): \(.title) (Assignee: \(.assignee.login // "Unassigned"))"'
}

# Function to close milestone
close_milestone() {
    local milestone_number=$1
    echo -e "${YELLOW}Closing milestone $milestone_number...${NC}"
    
    # Check if all issues are closed
    open_issues=$(gh api repos/$REPO_OWNER/$REPO_NAME/milestones/$milestone_number | jq -r '.open_issues')
    
    if [ "$open_issues" -gt 0 ]; then
        echo -e "${RED}Warning: $open_issues issues are still open. Close them first or move to another milestone.${NC}"
        return 1
    fi
    
    gh api repos/$REPO_OWNER/$REPO_NAME/milestones/$milestone_number \
        --method PATCH \
        --field state="closed"
    
    echo -e "${GREEN}Milestone $milestone_number closed successfully!${NC}"
}

# Main script logic
case "$1" in
    "status")
        show_milestone_status
        ;;
    "issues")
        if [ -z "$2" ]; then
            echo "Usage: $0 issues <milestone_number>"
            exit 1
        fi
        show_milestone_issues "$2"
        ;;
    "health")
        check_milestone_health
        ;;
    "report")
        if [ -z "$2" ]; then
            echo "Usage: $0 report <milestone_number>"
            exit 1
        fi
        generate_sprint_report "$2"
        ;;
    "close")
        if [ -z "$2" ]; then
            echo "Usage: $0 close <milestone_number>"
            exit 1
        fi
        close_milestone "$2"
        ;;
    *)
        echo "VoidRunner Milestone Management"
        echo "Usage: $0 {status|issues|health|report|close} [milestone_number]"
        echo ""
        echo "Commands:"
        echo "  status                    - Show all milestone status"
        echo "  issues <number>           - Show issues in specific milestone"
        echo "  health                    - Check milestone health and risks"
        echo "  report <number>           - Generate sprint report for milestone"
        echo "  close <number>            - Close completed milestone"
        echo ""
        echo "Examples:"
        echo "  $0 status                 # Show all milestones"
        echo "  $0 issues 1               # Show issues in milestone 1"
        echo "  $0 health                 # Check milestone health"
        echo "  $0 report 1               # Generate report for milestone 1"
        echo "  $0 close 1                # Close milestone 1"
        ;;
esac
