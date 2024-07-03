#!/bin/bash

# Ensure the script uses Unix line endings

# Get the current local username
current_user=$(stat -f "%Su" /dev/console)

# Set the GitHub raw link (corrected for direct download)
github_link="https://github.com/SwapTuck/ShellScriptFiles/blob/main/Desktop_Background_7680x4320px%20(4).jpg?raw=true"

# Set the file path
path="/Users/${current_user}/Desktop"
file="${path}/Desktop_Background.jpg"

echo "Current user: ${current_user}"
echo "Download path: ${file}"
echo "GitHub link: ${github_link}"

# Download the file using curl with retries
curl -L -o "${file}" "${github_link}"

# Check if download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download background image."
    exit 1
fi

# Confirm the file exists
if [ -f "${file}" ]; then
    echo "File downloaded successfully."
else
    echo "File not found."
    exit 1
fi

# Set desktop background using osascript with user interaction
sudo -u "${current_user}" osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${file}\""

# Check if setting background was successful
if [ $? -ne 0 ]; then
    echo "Failed to set desktop background."
    exit 1
fi

echo "Background image set successfully."
exit 0
