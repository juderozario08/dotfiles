#!/bin/bash

# Get JSON data from rocm-smi
smi_data=$(rocm-smi --showuse --showclocks --json 2>/dev/null)

# Parse GPU utilization (fallback to 0 if empty)
usage=$(echo "$smi_data" | jq -r '."card0"."GPU use (%)" // 0' | grep -oP '\d+' || echo "0")

# Parse Clocks
core_clock=$(echo "$smi_data" | jq -r '."card0"."sclk clock level" // 0' | grep -oP '\d+' || echo "0")
mem_clock=$(echo "$smi_data" | jq -r '."card0"."mclk clock level" // 0' | grep -oP '\d+' || echo "0")

# VRAM usage
mem_used_bytes=$(cat /sys/class/drm/card0/device/mem_info_vram_used 2>/dev/null || echo 0)
mem_total_bytes=$(cat /sys/class/drm/card0/device/mem_info_vram_total 2>/dev/null || echo 0)
mem_usage=$((mem_used_bytes / 1024 / 1024))
mem_total=$((mem_total_bytes / 1024 / 1024))

# Use jq to build the final JSON safely (Notice the -nc --unbuffered flags!)
jq -nc --unbuffered \
  --arg tex " ${usage}%" \
  --arg tip "GPU 0: ${usage}%
Memory: ${mem_usage} MiB / ${mem_total} MiB
Core: ${core_clock} MHz
Mem Clock: ${mem_clock} MHz" \
  '{text: $tex, tooltip: $tip, class: "gpu"}'
