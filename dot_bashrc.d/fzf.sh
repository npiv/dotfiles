# add if [[ "$OSTYPE" == darwin* ]]; then to case statement
eval "$(fzf --bash 2>/dev/null)"
#case "$OSTYPE" in
#"linux-gnu")
#	. /usr/share/fzf/shell/key-bindings.bash
#	;;
#darwin*)
#	if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
#		PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
#	fi
#	[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.bash" 2>/dev/null
#	source "/opt/homebrew/opt/fzf/shell/key-bindings.bash"
#	;;
#*)
#	echo "no fzf"
#	;;
#esac
