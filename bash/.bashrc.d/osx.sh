# macOS-only setup
# No-op on non-macOS hosts.
case "${OSTYPE:-$(uname -s | tr '[:upper:]' '[:lower:]')}" in
  darwin*) ;;
  *) return 0 2>/dev/null || exit 0 ;;
esac

# Initialize Homebrew environment (PATH and related vars)
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
