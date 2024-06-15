case "$OSTYPE" in
"linux-gnu")
	. /usr/share/autojump/autojump.bash
	;;
darwin*)
	[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
	;;
*)
	echo "no autojump"
	;;
esac
