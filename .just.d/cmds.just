
# Sudo and coreutils are required
LN := \
    if os_family() == "windows" {
        "sudo ln -sf"
    } else {
        "ln -sf"
    }
CLIP := \
    if os() == "windows" { "clip.exe" } \
    else if os() == "linux" { "wl-copy" } \
    else if os() == "macos" { "pbcopy" } \
    else { "" }


CURL := \
    if os() == "windows" { "Invoke-WebRequest" } \
    else if os() == "linux" { "curl -L" } \
    else if os() == "macos" { "curl -L" } \
    else { "" }

CURL_OUT := \
    if os() == "windows" { "-OutFile" } \
    else if os() == "linux" { "-o" } \
    else if os() == "macos" { "-o" } \
    else { "" }
