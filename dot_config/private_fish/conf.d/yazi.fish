function y
    # Create a temporary file
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    if test $status -ne 0; or not test -e "$tmp"
        echo "y: Failed to create temporary file." >&2
        return 1
    end

    # Run yazi with arguments, directing it to write CWD to the temp file
    yazi $argv --cwd-file="$tmp"

    # Read the CWD from the temp file, check if successful and content non-empty
    set -l cwd ""
    if command cat -- "$tmp" > /dev/null 2>&1 # Check if cat succeeds
        set cwd (command cat -- "$tmp")
    end

    # Change directory if CWD was read, is non-empty, and differs from current directory
    if test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end

    # Clean up the temporary file
    rm -f -- "$tmp"
end

