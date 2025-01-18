#!/bin/bash

# Set start and end date
START_DATE="2025-01-7"  # YYYY-MM-DD
END_DATE="2025-02-24"    # YYYY-MM-DD

# Min and max commits per selected day
MIN_COMMITS=3
MAX_COMMITS=4

# Min and max days per month to commit
MIN_DAYS_PER_MONTH=5
MAX_DAYS_PER_MONTH=10

# Set author and committer name and email
AUTHOR_NAME="nightfairy"
AUTHOR_EMAIL="nightfairy5831@gmail.com"

# Define an array of commit messages (20 total)
commit_messages=(
    "Initial commit"
    "Merge pull request from admin branch"
    "Merge pull request from dev branch"
    "Merge pull request from feature branch"
    "Merge pull request from test branch"
    "chore: adjust readme.md"
    "chore: update documentation"
    "feat: create admin dashboard"
    "feat: complete first version"
    "feat: update result dashboard"
    "feat: add video content script"
    "feat: update postidea agent"
    "feat: update project modal"
    "feat: update credits component"
    "feat: upgrade credits component"
    "fix: resolve server usage error"
    "fix: resolve dynamic server error"
    "fix: solve repeated post idea error"
    "fix: update credit component to match plan"
    "fix: update credit page"
    "fix: upgrade router"
    "fix: update postideas prompt"
    "feat: upgrade stripe feature for multi-language"
    "fix: minor bug fixes and improvements"
)



# Convert START_DATE to first day of the month
current_date=$(date -d "$START_DATE" +"%Y-%m-01")

# Loop through each month in the date range
while [[ "$current_date" < "$END_DATE" ]] || [[ "$current_date" == "$END_DATE" ]]; do
    # Get number of days in the current month
    days_in_month=$(date -d "$current_date +1 month -1 day" +"%d")

    # Random number of commit days for the month
    num_commit_days=$(( RANDOM % (MAX_DAYS_PER_MONTH - MIN_DAYS_PER_MONTH + 1) + MIN_DAYS_PER_MONTH ))

    # Select random days in the month
    commit_days=()
    while [[ ${#commit_days[@]} -lt $num_commit_days ]]; do
        random_day=$(( RANDOM % days_in_month + 1 ))
        if [[ ! " ${commit_days[@]} " =~ " $random_day " ]]; then
            commit_days+=("$random_day")
        fi
    done

    # Make commits on selected random days
    for day in "${commit_days[@]}"; do
        commit_date=$(date -d "$current_date +$((day-1)) days" +"%Y-%m-%d")

        # Random number of commits for the selected day
        num_commits=$(( RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS ))

        for ((i=1; i<=num_commits; i++)); do
            # Generate a random timestamp within the day
            commit_time=$(date -d "$commit_date $((RANDOM % 24)):$((RANDOM % 60)):$((RANDOM % 60))" +"%Y-%m-%d %H:%M:%S")

            # Pick a random commit message from the array
            commit_message=${commit_messages[$RANDOM % ${#commit_messages[@]}]}

            # Create or modify a file
            echo "Commit on $commit_time" >> dummy.txt

            # Add changes
            git add .

            # Commit with specific author details and timestamp
            GIT_AUTHOR_NAME="$AUTHOR_NAME" GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL" \
            GIT_COMMITTER_NAME="$AUTHOR_NAME" GIT_COMMITTER_EMAIL="$AUTHOR_EMAIL" \
            GIT_COMMITTER_DATE="$commit_time" GIT_AUTHOR_DATE="$commit_time" \
            git commit -m "$commit_message"
        done
    done

    # Move to the first day of the next month
    current_date=$(date -d "$current_date +1 month" +"%Y-%m-01")
done