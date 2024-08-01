alias vi=nvim
alias vim=nvim
alias gs="git status -sb"
alias cls="clear"
alias gla="git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"
alias gl="gla -20"
alias gll="gla --graph"
alias grep="grep --color"
alias gpom="git push origin master"
alias makepy="python3 -m venv .venv && . venv/bin/activate && pip install -r requirements.txt"
alias gopy=". .venv/bin/activate"
alias cdf='cd "$(fd -H -t directory -a | fzf)"'
alias c=chatblade
alias chat="chatblade -c 4t -s -i"
alias ask="chatblade -c 4t -s"
alias chedit="chezmoi edit --apply"

alias pnpx="pnpm dlx"

alias d=podman
alias k=kubectl

alias docker-by-mem='docker stats --no-stream --format "table {{.MemPerc}}\t{{.Name}}" | sort -r -k1'

function qpush() {
  git add --all
  git commit -m $1
  git push origin main
}

alias ls='eza --group-directories-first'
alias ll='ls -l'
alias l='ls --git-ignore'
alias la='ls -a'
alias lt='eza --tree --level=2 --long --git'
alias lta='lt -a'
alias ltg='lt --git-ignore'

export BAT_THEME="base16"
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

alias gob='vim "$(fd -t f . ~/Documents/darkwood/notes/ | fzf --preview "bat --color=always --wrap=character --style=plain --terminal-width=70 {}" --select-1 --exit-0 --delimiter / --with-nth -1)"'
