#!/bin/bash

# List of sinks to exclude (add more sinks here if needed)
EXCLUDED_SINKS=("alsa_output.pci-0000_00_1f.3.iec958-stereo")

# Get the list of sinks, excluding specified ones
SINKS=$(pactl list sinks short | awk '{print $2}' | grep -v -F "${EXCLUDED_SINKS[*]}")
CURRENT_SINK=$(pactl get-default-sink)

# Convert sinks to an array
SINK_ARRAY=($SINKS)
NUM_SINKS=${#SINK_ARRAY[@]}

# Exit if no sinks are available
if [ $NUM_SINKS -eq 0 ]; then
  notify-send "Audio Switch Error" "No valid audio sinks available"
  exit 1
fi

# Find the index of the current sink
CURRENT_INDEX=-1
for i in "${!SINK_ARRAY[@]}"; do
  if [[ "${SINK_ARRAY[$i]}" == "$CURRENT_SINK" ]]; then
    CURRENT_INDEX=$i
    break
  fi
done

# If current sink is not in the list (e.g., it's excluded), set to first available
if [ $CURRENT_INDEX -eq -1 ]; then
  NEXT_SINK=${SINK_ARRAY[0]}
else
  # Calculate the next sink index
  NEXT_INDEX=$(((CURRENT_INDEX + 1) % NUM_SINKS))
  NEXT_SINK=${SINK_ARRAY[$NEXT_INDEX]}
fi

# Set the next sink as default
pactl set-default-sink "$NEXT_SINK"

# Move all existing sink inputs to the new default sink
pactl list sink-inputs short | awk '{print $1}' | while read -r INPUT; do
  pactl move-sink-input "$INPUT" "$NEXT_SINK"
done

# Notify the user (optional, requires libnotify)
notify-send "Audio Output" "Switched to $NEXT_SINK"
