set -e # Exit immediately if a command exits with a non-zero status

declare -A linkDots


source "$DOTFILES/bootstrap/components/symlinks.sh"

echo "[INFO] DOTFILES = $DOTFILES"

echo "[ACTION] Press any key to proceed"
read -n 1

echo "[INFO] Setting up symbolic links"

for src in "${!linkDots[@]}"; do
    dest="${linkDots[$src]}"
    echo "Linking $src to $dest"
    if [ -d "$src" ]; then
        test -d "$dest" && mv "$dest" "$dest.bak"
        ln -sf "$src" "$dest"
    elif [ -f "$src" ]; then
        dest_parent=$(dirname "$dest")
        test -d "$dest_parent" || mkdir -p "$dest_parent"
        ln -sf "$src" "$dest"
    else
        echo "[ERROR] $src does not exist"
    fi
done
