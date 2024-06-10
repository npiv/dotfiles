case "$OSTYPE" in
"linux-gnu")
	. /usr/share/autojump/autojump.bash
	;;
*)
	echo "no autojump"
	;;
esac
