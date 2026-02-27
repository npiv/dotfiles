export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR="nvim"

# Shell behavior
set -o vi
# In vi insert mode, bind Ctrl-l to clear-screen (default is unbound and inserts ^L)
bind -m vi-insert '"\C-l": clear-screen'
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="$HISTSIZE"

# Paths
# User-local executables from tools/package managers (e.g. bunx shims)
export PATH="$HOME/.local/bin:$PATH"

# Personal scripts managed in this dotfiles repo (stowed from userbin/)
export PATH="$HOME/.local/userbin:$PATH"

# Load modular bash config snippets (paths, functions, OS-specific tweaks, ...)
if [ -d "$HOME/.bashrc.d" ]; then
  for rc_file in "$HOME"/.bashrc.d/*; do
    [ -f "$rc_file" ] || continue
    # shellcheck disable=SC1090
    . "$rc_file"
  done
fi

load_env_vars() {
  local env_file="$1"
  [ -f "$env_file" ] || return 0

  set -a
  # shellcheck disable=SC1090
  . "$env_file"
  set +a
}

# Interactive init
if [[ $- == *i* ]]; then
  if command -v zoxide >/dev/null 2>&1; then
    export _ZO_DOCTOR=0
    eval "$(zoxide init bash)"
  fi

  # Initialize starship before atuin (atuin defines preexec/precmd arrays;
  # starship should install its prompt hook via PROMPT_COMMAND first).
  if command -v starship >/dev/null 2>&1 && [ -f "$HOME/.config/starship.toml" ]; then
    eval "$(starship init bash)"
  fi

  if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash --disable-up-arrow)"
  fi

  load_env_vars "$HOME/.config/.secret.env"
fi

# Aliases
alias try='try-rs'
alias vi='nvim'
alias vim='nvim'

alias gs='git status -sb'
alias gla="git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"
alias gl='gla -20'
alias gll='gla --graph'
alias gpom='git push origin main'

alias cls='clear'
alias grep='grep --color=auto'
alias ls='eza --group-directories-first'
alias ll='ls -l'
alias l='ls --git-ignore'
alias la='ls -a'
alias lt='eza --tree --level=2 --long --git'
alias lta='lt -a'
alias ltg='lt --git-ignore'

alias makepy='python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt'
alias gopy='source .venv/bin/activate'

alias ff='fzf --preview "bat --style=numbers --color=always {}"'

alias pnpx='pnpm dlx'

alias k='kubectl'
alias docker-by-mem='docker stats --no-stream --format "table {{.MemPerc}}\t{{.Name}}" | sort -r -k1'

qpush() {
  if [ $# -eq 0 ]; then
    echo 'usage: qpush <commit message>' >&2
    return 1
  fi

  git add --all
  git commit -m "$*"
  git push origin main
}

cdf() {
  local dir
  dir="$(fd -H -t directory -a | fzf)"
  [ -n "$dir" ] && cd "$dir"
}

gob() {
  local file
  file="$(fd -t f . ~/Documents/32gratitude/ | fzf --preview 'bat --color=always --wrap=character --style=plain --terminal-width=70 {}' --select-1 --exit-0 --delimiter / --with-nth -1)"
  [ -n "$file" ] && nvim "$file"
}

y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return 1

  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi

  rm -f -- "$tmp"
}

deploy-compose() {
  ./deploy-compose "$@"
}

llmv() {
  local tmpfile editor_status
  tmpfile="$(mktemp)" || {
    echo 'llmv: failed to create temp file' >&2
    return 1
  }

  if ! [ -t 0 ]; then
    cat > "$tmpfile"
  fi

  "${EDITOR:-vi}" "$tmpfile"
  editor_status=$?

  if [ "$editor_status" -eq 0 ]; then
    if [ -s "$tmpfile" ]; then
      cat "$tmpfile" | llm "$@"
    else
      echo 'llmv: temp file empty after editing, not running llm.' >&2
    fi
  else
    echo "llmv: editor exited with status $editor_status. aborting." >&2
  fi

  rm -f "$tmpfile"
}
