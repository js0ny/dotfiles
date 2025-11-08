#!/bin/sh

echo "[INFO] Use TouchID to authenticate before running sudo commands."
echo "[WARNING] This operation modifies critical system files."
echo "          If something goes wrong, you may need to boot into macOS Recovery Mode to restore your system."
echo "[ACTION] To continue, type EXACTLY 'yes' and press Enter."
read -p "Do you want to continue? (yes/no): " response
if [ "$response" != "yes" ]; then
    echo "[INFO] Operation cancelled."
    exit 0 # Exit with success status code
fi
echo ""

set -x
sudo cp ~/.dotfiles/misc/mac/etc/pam.d/sudo /etc/pam.d/sudo
set +x
