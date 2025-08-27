#!/usr/bin/env bash

if [[ -z "$1" ]]; then
	echo "please provide file path"
	exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "not a file"
	exit 1
fi

log_file="$1"

#top 5 ip by request
echo "Top 5 IP addresses with most requests"
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo -e "\n"

#top 5 most requested path
echo "Top 5 most requested path"
awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo -e "\n"

#top 5 response status code
echo "Top 5 response status code"
awk '{print $9}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo -e "\n"

#top 5 user agents
echo "Top 5 user agents"
awk -F\" '{print $6}' "$log_file" | sort | uniq -c | sort -nr | head -5 | awk '{count=$1;$1="";print substr($0,2) " - " count " requests"}'
echo -e "\n"

