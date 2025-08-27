#!/usr/bin/env bash
set -euo pipefail

if [[ -z "$1" ]]; then
	echo "Give directory name as well please"
	exit 1
fi

if [[ ! -d "$1" ]]; then
	echo "Not a valid directory"
	exit 1
fi

log_dir="$1"
out_dir="$HOME/archieves"
mkdir -p "$out_dir"

timestamp=$(date +"%Y%m%d_%H%M%S")
arc_name="log_arhcieve_${timestamp}.tar.gz"
arc_path="${out_dir}/${arc_name}"

tar -cvzf "$arc_path" "$log_dir"

log_op="$HOME/logs_arch"
mkdir -p "$log_op"

log_op_dir="${log_op}/logs.txt"
echo "Archieved ${arc_name} at ${timestamp}" >> "$log_op_dir"
