#!/bin/bash

# Collect memory usage and stack name for each container
docker stats --no-stream --format "{{.Name}} {{.MemUsage}}" \
| while read -r name mem; do
    usage=$(echo "$mem" | cut -d'/' -f1 | sed 's/[^0-9\.]*//g')
    unit=$(echo "$mem" | cut -d'/' -f1 | sed 's/[0-9\.]*//g' | tr -d ' ')

    # Convert to MiB
    case "$unit" in
        kB|KB) usage_mib=$(echo "$usage / 1024" | bc -l) ;;
        MB|MiB) usage_mib="$usage" ;;
        GB|GiB) usage_mib=$(echo "$usage * 1024" | bc -l) ;;
        *) usage_mib="$usage" ;;  # fallback if unknown
    esac

    stack=$(docker inspect -f '{{ index .Config.Labels "com.docker.compose.project" }}' "$name" 2>/dev/null)
    echo "$stack $usage_mib"
done | awk '{mem[$1]+=$2} END {for (s in mem) printf "%-20s %10.2f MiB\n", s, mem[s]}' | sort -k2 -nr
