if status is-interactive
    atuin init fish --disable-up-arrow | source
    load_env_vars ~/.config/.secret.env
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export PATH /Users/npiv/code/data/bin/ $PATH
