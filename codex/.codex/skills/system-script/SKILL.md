---
name: system-script
description: create a new system script that the user can run 
---

The location ~/.local/userbin is on the user's path and should be where we place all the custom scripts that the user can run.

To make the scripts easy to remember we will try to use Verbs and shorten from there.

For example if we had a script that `Waters Plants` then we would create it as WaterPlants in the active form

The scripts must always be standalone, and executable. If they are mostly running commands, and piping we can get away with just a bash script.

If the script is more complex than use Either typescript or python.

If the script is typescript we always use bun, or for python we always use uv.

The scripts must always be executable on their own using a correct #!/bin/bash, and in the case of uv they should use the uv format to pull in dependencies
on the fly.
