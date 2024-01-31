#!/bin/bash

# Path to the pre-commit hook
hook_file=".git/hooks/pre-commit"

# Check if the pre-commit hook file already exists
if [ ! -f "$hook_file" ]; then
  # Create the pre-commit hook file
  touch $hook_file

  # Make the file executable
  chmod +x $hook_file

  # Write the file size checking script into the pre-commit hook file
  cat << 'EOF' > $hook_file
#!/bin/sh

# Pre-commit hook that checks for files larger than 50KB
# If such a file is found, the commit is aborted

over_sized_files=$(find . -type f -size +50k)

if [ -n "$over_sized_files" ]; then
  echo "The following files are larger than 50KB:"
  echo "$over_sized_files"
  exit 1
fi

exit 0
EOF
fi

# Check file sizes
over_sized_files=$(find . -type f -size +50k)

if [ -n "$over_sized_files" ]; then
  echo "The following files are larger than 50KB:"
  echo "$over_sized_files"
fi