#!/bin/sh
input=$(cat)

# Model name
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')

# Context window usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
output_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // empty')

# Build progress bar (10 chars wide)
if [ -n "$used_pct" ]; then
  filled=$(echo "$used_pct" | awk '{printf "%d", ($1 * 10 / 100) + 0.5}')
  empty=$((10 - filled))
  bar=""
  i=0
  while [ $i -lt $filled ]; do
    bar="${bar}#"
    i=$((i + 1))
  done
  i=0
  while [ $i -lt $empty ]; do
    bar="${bar}-"
    i=$((i + 1))
  done
  pct_display=$(printf "%.0f%%" "$used_pct")
else
  bar="----------"
  pct_display="n/a"
fi

# Build current usage string
if [ -n "$input_tokens" ] && [ -n "$output_tokens" ]; then
  usage_str="in:${input_tokens} out:${output_tokens}"
  if [ -n "$cache_read" ] && [ "$cache_read" -gt 0 ] 2>/dev/null; then
    usage_str="${usage_str} cache:${cache_read}"
  fi
else
  usage_str=""
fi

# Rate limits
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Format reset time as HH:MM
format_reset() {
  ts="$1"
  fmt="$2"
  if [ -n "$ts" ]; then
    date -r "$ts" "$fmt" 2>/dev/null || date -d "@$ts" "$fmt" 2>/dev/null
  fi
}

five_reset_time=$(format_reset "$five_resets" "+%H:%M")
seven_reset_time=$(format_reset "$seven_resets" "+%-m/%-d %H:%M")

# Output: model | [####----] 20% | in:X out:Y | 5h:XX% resets HH:MM | 7d:XX% resets HH:MM
printf "\033[1;36m%s\033[0m" "$model"
printf " \033[2m[\033[0m\033[1;33m%s\033[0m\033[2m]\033[0m \033[1;33m%s\033[0m" "$bar" "$pct_display"
if [ -n "$usage_str" ]; then
  printf " \033[2m%s\033[0m" "$usage_str"
fi
if [ -n "$five_pct" ]; then
  five_pct_fmt=$(printf "%.0f" "$five_pct")
  if [ -n "$five_reset_time" ]; then
    printf " \033[2m|\033[0m \033[1;35m5h:%s%%\033[0m \033[2mreset:%s\033[0m" "$five_pct_fmt" "$five_reset_time"
  else
    printf " \033[2m|\033[0m \033[1;35m5h:%s%%\033[0m" "$five_pct_fmt"
  fi
fi
if [ -n "$seven_pct" ]; then
  seven_pct_fmt=$(printf "%.0f" "$seven_pct")
  if [ -n "$seven_reset_time" ]; then
    printf " \033[2m|\033[0m \033[1;35m7d:%s%%\033[0m \033[2mreset:%s\033[0m" "$seven_pct_fmt" "$seven_reset_time"
  else
    printf " \033[2m|\033[0m \033[1;35m7d:%s%%\033[0m" "$seven_pct_fmt"
  fi
fi
