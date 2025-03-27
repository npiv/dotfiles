# Fish shell completions for llm CLI
# https://llm.datasette.io/

function __fish_llm_last_arg
    echo (commandline -cx)[-1]
end

function __fish_llm_using_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1
        if test $argv[1] = $cmd[2]
            return 0
        end
    end
    return 1
end

function __fish_llm_using_subcommand
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 2
        if test $argv[1] = $cmd[2]; and test $argv[2] = $cmd[3]
            return 0
        end
    end
    return 1
end

function __fish_llm_get_models
    # Get available models
    # Format: "OpenAI Chat: gpt-4o (aliases: 4o)"
    # Extract both the model name and aliases
    set -l models (llm models list 2>/dev/null)
    for model in $models
        # Extract the model name (e.g., "gpt-4o")
        echo $model | string replace -r '^[^:]+: ([^ ]+).*$' '$1'
        
        # Extract aliases if present (e.g., "4o")
        set -l aliases (echo $model | string match -r 'aliases: ([^)]+)')
        if test -n "$aliases"
            echo $aliases[2] | string split ', '
        end
    end
end

function __fish_llm_get_templates
    # Get available templates
    llm templates list 2>/dev/null | string replace -r '^([^ ]+).*$' '$1'
end

# Main command completions
complete -c llm -f

# Global options
complete -c llm -l version -d "Show the version and exit"
complete -c llm -l help -d "Show help message and exit"

# Default command is 'prompt'
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -s m -l model -d "Model to use" -xa "(__fish_llm_get_models)"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -s s -l system -d "System prompt to use"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -s t -l template -d "Template to use" -xa "(__fish_llm_get_templates)"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -l no-stream -d "Don't stream output"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -l schema -d "Schema to use"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -l no-log -d "Don't log this prompt and response"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -l key -d "API key to use"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -l caching -d "Control caching" -xa "enable disable"
complete -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -s o -l option -d "Set model options"

# Subcommands
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "prompt" -d "Execute a prompt"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "aliases" -d "Manage model aliases"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "chat" -d "Hold an ongoing chat with a model"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "collections" -d "View and manage collections of embeddings"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "embed" -d "Embed text and store or return the result"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "embed-models" -d "Manage available embedding models"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "embed-multi" -d "Store embeddings for multiple strings at once"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "gemini" -d "Commands relating to the llm-gemini plugin"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "install" -d "Install packages from PyPI into the same environment as LLM"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "keys" -d "Manage stored API keys for different models"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "logs" -d "Tools for exploring logged prompts and responses"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "models" -d "Manage available models"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "openai" -d "Commands for working directly with the OpenAI API"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "plugins" -d "List installed plugins"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "schemas" -d "Manage stored schemas"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "similar" -d "Return top N similar IDs from a collection using cosine similarity"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "templates" -d "Manage stored prompt templates"
complete -f -c llm -n "not __fish_seen_subcommand_from prompt aliases chat collections embed embed-models embed-multi gemini install keys logs models openai plugins schemas similar templates uninstall" -a "uninstall" -d "Uninstall Python packages from the LLM environment"

# 'prompt' command options (same as global options since it's the default command)
complete -c llm -n "__fish_llm_using_command prompt" -s m -l model -d "Model to use" -xa "(__fish_llm_get_models)"
complete -c llm -n "__fish_llm_using_command prompt" -s s -l system -d "System prompt to use"
complete -c llm -n "__fish_llm_using_command prompt" -s t -l template -d "Template to use" -xa "(__fish_llm_get_templates)"
complete -c llm -n "__fish_llm_using_command prompt" -l no-stream -d "Don't stream output"
complete -c llm -n "__fish_llm_using_command prompt" -l schema -d "Schema to use"
complete -c llm -n "__fish_llm_using_command prompt" -l no-log -d "Don't log this prompt and response"
complete -c llm -n "__fish_llm_using_command prompt" -l key -d "API key to use"
complete -c llm -n "__fish_llm_using_command prompt" -l caching -d "Control caching" -xa "enable disable"
complete -c llm -n "__fish_llm_using_command prompt" -s o -l option -d "Set model options"

# 'models' subcommand
complete -f -c llm -n "__fish_llm_using_command models; and not __fish_seen_subcommand_from list default" -a "list" -d "List available models"
complete -f -c llm -n "__fish_llm_using_command models; and not __fish_seen_subcommand_from list default" -a "default" -d "Show or set the default model"

# 'models list' options
complete -c llm -n "__fish_llm_using_subcommand models list" -l options -d "Show options for each model if available"
complete -c llm -n "__fish_llm_using_subcommand models list" -l async -d "List async models"
complete -c llm -n "__fish_llm_using_subcommand models list" -l schemas -d "List models that support schemas"
complete -c llm -n "__fish_llm_using_subcommand models list" -s q -l query -d "Search for models matching these strings"

# 'models default' options
complete -c llm -n "__fish_llm_using_subcommand models default" -xa "(__fish_llm_get_models)"

# 'templates' subcommand
complete -f -c llm -n "__fish_llm_using_command templates; and not __fish_seen_subcommand_from list edit path show" -a "list" -d "List available prompt templates"
complete -f -c llm -n "__fish_llm_using_command templates; and not __fish_seen_subcommand_from list edit path show" -a "edit" -d "Edit the specified prompt template using the default \$EDITOR"
complete -f -c llm -n "__fish_llm_using_command templates; and not __fish_seen_subcommand_from list edit path show" -a "path" -d "Output the path to the templates directory"
complete -f -c llm -n "__fish_llm_using_command templates; and not __fish_seen_subcommand_from list edit path show" -a "show" -d "Show the specified prompt template"

# 'templates edit' and 'templates show' options
complete -c llm -n "__fish_llm_using_subcommand templates edit; or __fish_llm_using_subcommand templates show" -xa "(__fish_llm_get_templates)"

# 'chat' command options
complete -c llm -n "__fish_llm_using_command chat" -s m -l model -d "Model to use" -xa "(__fish_llm_get_models)"
complete -c llm -n "__fish_llm_using_command chat" -s s -l system -d "System prompt to use"
complete -c llm -n "__fish_llm_using_command chat" -l no-stream -d "Don't stream output"
complete -c llm -n "__fish_llm_using_command chat" -l key -d "API key to use"
complete -c llm -n "__fish_llm_using_command chat" -s o -l option -d "Set model options"

# 'keys' subcommand
complete -f -c llm -n "__fish_llm_using_command keys; and not __fish_seen_subcommand_from set get path" -a "set" -d "Store a key for a specific model"
complete -f -c llm -n "__fish_llm_using_command keys; and not __fish_seen_subcommand_from set get path" -a "get" -d "Get a key for a specific model"
complete -f -c llm -n "__fish_llm_using_command keys; and not __fish_seen_subcommand_from set get path" -a "path" -d "Output the path to the keys directory"

# 'aliases' subcommand
complete -f -c llm -n "__fish_llm_using_command aliases; and not __fish_seen_subcommand_from set get list" -a "set" -d "Set an alias for a model"
complete -f -c llm -n "__fish_llm_using_command aliases; and not __fish_seen_subcommand_from set get list" -a "get" -d "Get the model for an alias"
complete -f -c llm -n "__fish_llm_using_command aliases; and not __fish_seen_subcommand_from set get list" -a "list" -d "List all aliases"

# 'schemas' subcommand
complete -f -c llm -n "__fish_llm_using_command schemas; and not __fish_seen_subcommand_from list get set path" -a "list" -d "List available schemas"
complete -f -c llm -n "__fish_llm_using_command schemas; and not __fish_seen_subcommand_from list get set path" -a "get" -d "Get a schema"
complete -f -c llm -n "__fish_llm_using_command schemas; and not __fish_seen_subcommand_from list get set path" -a "set" -d "Set a schema"
complete -f -c llm -n "__fish_llm_using_command schemas; and not __fish_seen_subcommand_from list get set path" -a "path" -d "Output the path to the schemas directory"

# 'embed' command options
complete -c llm -n "__fish_llm_using_command embed" -s m -l model -d "Embedding model to use"
complete -c llm -n "__fish_llm_using_command embed" -s c -l collection -d "Collection to store the embedding in"
complete -c llm -n "__fish_llm_using_command embed" -s i -l id -d "ID to use for this embedding"
complete -c llm -n "__fish_llm_using_command embed" -l metadata -d "Metadata to store with the embedding"
complete -c llm -n "__fish_llm_using_command embed" -l store -d "Store the embedding in the collection"
complete -c llm -n "__fish_llm_using_command embed" -l key -d "API key to use"

# 'embed-models' subcommand
complete -f -c llm -n "__fish_llm_using_command embed-models; and not __fish_seen_subcommand_from list" -a "list" -d "List available embedding models"

# 'collections' subcommand
complete -f -c llm -n "__fish_llm_using_command collections; and not __fish_seen_subcommand_from list create delete path" -a "list" -d "List available collections"
complete -f -c llm -n "__fish_llm_using_command collections; and not __fish_seen_subcommand_from list create delete path" -a "create" -d "Create a new collection"
complete -f -c llm -n "__fish_llm_using_command collections; and not __fish_seen_subcommand_from list create delete path" -a "delete" -d "Delete a collection"
complete -f -c llm -n "__fish_llm_using_command collections; and not __fish_seen_subcommand_from list create delete path" -a "path" -d "Output the path to the collections directory"

# 'logs' subcommand
complete -f -c llm -n "__fish_llm_using_command logs; and not __fish_seen_subcommand_from list get path" -a "list" -d "List logged prompts and responses"
complete -f -c llm -n "__fish_llm_using_command logs; and not __fish_seen_subcommand_from list get path" -a "get" -d "Get a specific logged prompt and response"
complete -f -c llm -n "__fish_llm_using_command logs; and not __fish_seen_subcommand_from list get path" -a "path" -d "Output the path to the logs directory"

# 'plugins' command options
complete -c llm -n "__fish_llm_using_command plugins" -l all -d "Include plugins that are part of the core LLM package"
