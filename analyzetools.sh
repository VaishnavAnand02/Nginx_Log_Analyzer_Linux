#!/usr/bin/env bash
set -euo pipefail

if [[ -z "$1" ]]; then
    echo "please provide file path"
    exit 1
fi

if [[ ! -f "$1" ]]; then
    echo "not a file"
    exit 1
fi

log_file="$1"

# Top 5 IP addresses with most requests
echo "Top 5 IP addresses with most requests:"
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo -e "\n"

# Top 5 most requested paths
echo "Top 5 most requested paths:"
awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo -e "\n"

# Top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo -e "\n"

# Top 5 user agents
echo "Top 5 user agents:"
awk -F'"' 'NF >= 8 {print $8}' "$log_file" | \
    sort | uniq -c | sort -nr | head -5 | \
    awk '{
        gsub(/^ +/, "", $0)  # trim leading space
        count = $1
        sub(/^[^ ]+ +/, "")  # remove the count field
        print $0 " - " count " requests"
    }'
echo -e "\n"
