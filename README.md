## SHELL-SCRIPTS

### TEMP DIRECTORY CREATION

This function creates a temporary directory that is removed at the completion of the script. Any temporary files that are needed are written here.

```bash
tmpDir="/tmp/${scriptName}.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "${tmpDir}") || {
  die "Could not create temporary directory! Exiting."
}
```

### TRAP CLEANUP

If something unexpectedly goes wrong when running the script, this trap cleanup function is invoked which cleans up the temporary directory and prints a message to the user.

```bash
function trapCleanup() {
  if is_dir "${tmpDir}"; then
    rm -r "${tmpDir}"
  fi
  die "Exit trapped."  # Edit this if you like.
}

trap trapCleanup EXIT INT TERM
```

### LOGGING

A log file is created when needed.

```
logFile="$HOME/Library/Logs/${scriptBasename}.log"
```


### DEBUG AND STRICT MODE

By setting flags, any script can be invoked in debug or strict mode.

```bash
# Run in debug mode, if set
if [ "${debug}" == "1" ]; then
  set -x
fi

# Exit on empty variable
if [ "${strict}" == "1" ]; then
  set -o nounset
fi
```