# Tmux AI helper layouts.
# These helpers accept `pi` or `codex` (or any command as a fallback).

__tmuxai_resolve_agent_cmd() {
  case "$1" in
    pi|Pi|PI) echo "pi" ;;
    codex|Codex|CODEX) echo "codex" ;;
    *) echo "$1" ;;
  esac
}

# Create a tmux dev layout with editor + AI pane (+ optional second AI pane) + terminal strip.
# Usage: CreateAiDevLayout <pi|codex|command> [<second_pi|second_codex|second_command>]
CreateAiDevLayout() {
  if [ -z "$1" ]; then
    echo "Usage: CreateAiDevLayout <pi|codex|command> [<second_pi|second_codex|second_command>]"
    return 1
  fi
  if [ -z "$TMUX" ]; then
    echo "You must start tmux to use CreateAiDevLayout."
    return 1
  fi

  local current_dir editor_pane ai_pane ai2_pane
  local ai_cmd ai2_cmd
  current_dir="$PWD"
  editor_pane="$TMUX_PANE"
  ai_cmd="$(__tmuxai_resolve_agent_cmd "$1")"
  ai2_cmd=""
  if [ -n "$2" ]; then
    ai2_cmd="$(__tmuxai_resolve_agent_cmd "$2")"
  fi

  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Bottom terminal strip (15%)
  tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"

  # Right AI pane (30%)
  ai_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  # Optional second AI pane under the first AI pane
  if [ -n "$ai2_cmd" ]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" "$ai2_cmd" C-m
  fi

  tmux send-keys -t "$ai_pane" "$ai_cmd" C-m
  tmux send-keys -t "$editor_pane" "${EDITOR:-nvim} ." C-m
  tmux select-pane -t "$editor_pane"
}

# Create one tmux window per subdirectory, each with CreateAiDevLayout.
# Usage: CreateAiDevLayoutsForSubdirs <pi|codex|command> [<second_pi|second_codex|second_command>]
CreateAiDevLayoutsForSubdirs() {
  if [ -z "$1" ]; then
    echo "Usage: CreateAiDevLayoutsForSubdirs <pi|codex|command> [<second_pi|second_codex|second_command>]"
    return 1
  fi
  if [ -z "$TMUX" ]; then
    echo "You must start tmux to use CreateAiDevLayoutsForSubdirs."
    return 1
  fi

  local base_dir first dir dirpath pane_id
  local layout_cmd dir_quoted
  base_dir="$PWD"
  first=1

  tmux rename-session "$(basename "$base_dir" | tr '.:' '--')"

  layout_cmd="CreateAiDevLayout $(printf '%q' "$1")"
  if [ -n "$2" ]; then
    layout_cmd="$layout_cmd $(printf '%q' "$2")"
  fi

  for dir in "$base_dir"/*/; do
    [ -d "$dir" ] || continue
    dirpath="${dir%/}"

    if [ "$first" -eq 1 ]; then
      dir_quoted=$(printf '%q' "$dirpath")
      tmux send-keys -t "$TMUX_PANE" "cd $dir_quoted && $layout_cmd" C-m
      first=0
    else
      pane_id=$(tmux new-window -c "$dirpath" -P -F '#{pane_id}')
      tmux send-keys -t "$pane_id" "$layout_cmd" C-m
    fi
  done

  if [ "$first" -eq 1 ]; then
    echo "No subdirectories found in: $base_dir"
    return 1
  fi
}

# Create a multi-pane swarm layout and run the same command in all panes.
# Usage: CreateAiSwarmLayout <pane_count> <pi|codex|command...>
CreateAiSwarmLayout() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: CreateAiSwarmLayout <pane_count> <pi|codex|command...>"
    return 1
  fi
  if [ -z "$TMUX" ]; then
    echo "You must start tmux to use CreateAiSwarmLayout."
    return 1
  fi

  local count current_dir cmd
  local -a panes
  count="$1"
  shift

  case "$count" in
    ''|*[!0-9]*)
      echo "pane_count must be a positive integer"
      return 1
      ;;
  esac
  if [ "$count" -lt 1 ]; then
    echo "pane_count must be >= 1"
    return 1
  fi

  if [ "$#" -eq 1 ]; then
    cmd="$(__tmuxai_resolve_agent_cmd "$1")"
  else
    cmd="$*"
  fi

  current_dir="$PWD"
  panes=("$TMUX_PANE")
  tmux rename-window -t "$TMUX_PANE" "$(basename "$current_dir")"

  while [ "${#panes[@]}" -lt "$count" ]; do
    local split_target new_pane last_index
    last_index=$((${#panes[@]} - 1))
    split_target="${panes[$last_index]}"

    new_pane=$(tmux split-window -h -t "$split_target" -c "$current_dir" -P -F '#{pane_id}')
    panes+=("$new_pane")
    tmux select-layout -t "${panes[0]}" tiled
  done

  local pane
  for pane in "${panes[@]}"; do
    tmux send-keys -t "$pane" "$cmd" C-m
  done

  tmux select-pane -t "${panes[0]}"
}
