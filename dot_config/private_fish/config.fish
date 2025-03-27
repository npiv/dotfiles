if status is-interactive
    atuin init fish --disable-up-arrow | source
    load_env_vars ~/.config/.secret.env
    # Commands to run in interactive sessions can go here
end
