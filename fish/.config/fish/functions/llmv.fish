function llmv --description "Edit text in vi, pipe to llm, passing arguments" --wraps llm
    # 1. Create a temporary file
    set -l tmpfile (mktemp)

    # Check if mktemp failed
    if test $status -ne 0; or not test -e "$tmpfile"
        echo "Error: Failed to create temporary file." >&2
        return 1
    end

    # 2. Use begin...always...end for robust cleanup
    begin
        # 3. If data is being piped into this function, write it to the temp file first
        if not isatty stdin
            cat > $tmpfile
        end

        # 4. Open the temporary file in vi
        #    You could use $EDITOR or $VISUAL here if you prefer: ${EDITOR:-${VISUAL:-vi}}
        vi $tmpfile

        # 5. Check vi's exit status. Proceed only if it exited normally (usually 0)
        set -l vi_status $status
        if test $vi_status -eq 0
            # 6. Check if the file has content before piping
            if test -s $tmpfile
                # Execute the command: pipe temp file content to llm
                # $argv contains all arguments passed to the pipevi function
                # Fish automatically expands the list $argv into separate arguments here
                #echo "Executing: cat '$tmpfile' | llm $argv" >&2 # Optional debug message
                cat $tmpfile | llm $argv
            else
                echo "pipevi: Temp file empty after editing, not running llm." >&2
            end
        else
            echo "pipevi: vi exited with status $vi_status. Aborting." >&2
            # Optional: Return the editor's non-zero status code
            # return $vi_status
        end

    # 7. This 'always' block ensures cleanup happens even if vi fails or is cancelled
    end

    trap "rm $tmpfile" QUIT
end
