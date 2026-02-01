# --- Aliases ---

# Editor
alias vi nvim
alias vim nvim

# Git
alias gs "git status -sb"
alias gla "git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"
alias gl "gla -20"
alias gll "gla --graph"
alias gpom "git push origin main" # Consider changing 'master' to 'main' if that's your default branch

# General Utils
alias cls clear
alias grep "grep --color=auto" # --color=auto is often preferred in modern systems
alias ls 'eza --group-directories-first'
alias ll 'ls -l'
alias l 'ls --git-ignore'
alias la 'ls -a'
alias lt 'eza --tree --level=2 --long --git'
alias lta 'lt -a'
alias ltg 'lt --git-ignore'

# Python Virtual Env (using standard .fish activator)
# Note: Ensure your venv creates/has the activate.fish script
alias makepy "python3 -m venv .venv; and source .venv/bin/activate.fish; and pip install -r requirements.txt"
alias gopy "source .venv/bin/activate.fish"

# Directory Navigation / File Finding (using fd and fzf)
# Fish uses parentheses () for command substitution, not $()
alias cdf 'cd (fd -H -t directory -a | fzf)'
alias ff "fzf --preview 'bat --style=numbers --color=always {}'"
# Assuming 'vim' alias above, this will use nvim. Uses Fish command substitution.
alias gob 'nvim (fd -t f . ~/Documents/darkwood/notes/ | fzf --preview "bat --color=always --wrap=character --style=plain --terminal-width=70 {}" --select-1 --exit-0 --delimiter / --with-nth -1)'

# AI / Chat Tools
alias aideride 'aider --watch-files --no-auto-commits --yes-always --gitignore'

# Journal Processing
alias complete_journal 'uv run ~/bin/process_journal.py --file ~/Documents/32gratitude/Journal/(date +%Y-%m-%d).md'
alias complete_journal_gem 'uv run ~/bin/process_journal.py --file ~/Documents/32gratitude/Journal/(date +%Y-%m-%d).md --provider gemini'

# Chezmoi
alias chedit "chezmoi edit --apply"

# Node / PNPM
alias pnpx "pnpm dlx"

# Containers / K8s
alias d podman
alias k kubectl
alias docker-by-mem 'docker stats --no-stream --format "table {{.MemPerc}}\t{{.Name}}" | sort -r -k1'

# fabric
alias fabric fabric-ai
alias ?? fabric-ai

# --- Environment Variables ---

# Git quick push (add all, commit with message, push to origin main)
# Fish functions use $argv for arguments, $argv[1] corresponds to $1 in bash
function qpush
    git add --all
    # Quote argument for messages with spaces
    git commit -m "$argv[1]"
    # Consider parameterizing the branch name 'main' if needed
    git push origin main
end
