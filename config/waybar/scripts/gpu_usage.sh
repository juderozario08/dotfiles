#!/bin/bash

# Get usage %
usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n1)
# Get memory usage
mem_usage=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | head -n1)
mem_total=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -n1)
# Get memory bandwidth (optional - may not be available directly)
bw_usage=$(nvidia-smi dmon -s u -c 1 | awk 'NR==3 {print $2}' 2>/dev/null)
# Get clocks
core_clock=$(nvidia-smi --query-gpu=clocks.gr --format=csv,noheader,nounits | head -n1)
mem_clock=$(nvidia-smi --query-gpu=clocks.mem --format=csv,noheader,nounits | head -n1)

# Output JSON to Waybar
echo "{
  \"text\": \" ${usage}%\",
  \"tooltip\": \"GPU 0: ${usage}%\\nMemory Usage: ${mem_usage} MiB / ${mem_total} MiB\\nMemory Bandwidth: ${bw_usage}%\\nCore Clock: ${core_clock} MHz\\nMemory Clock: ${mem_clock} MHz\"
}" | jq --unbuffered --compact-output
