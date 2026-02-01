if status is-interactive
    atuin init fish --disable-up-arrow | source
    load_env_vars ~/.config/.secret.env
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path -g $BUN_INSTALL/bin /Users/npiv/.local/userbin

# lifedashboard
alias UpdateDashboard="cd /Users/npiv/code/lifedashboard; bun feeder:prod --all --days 1"
