OS := \
    if os() == "linux" {
        if env("WSL_DISTRO_NAME","") != "" {
            "wsl"
        } else {
            "linux"
        }
    } else if os() == "windows" {
        "win"
    } else if os() == "macos" {
        "mac"
    } else { "" }
DOTFILES := join(home_directory(), ".dotfiles")
XDG_CONFIG_HOME := \
    if env("XDG_CONFIG_HOME", "") != "" {env("XDG_CONFIG_HOME", "")} \
    else {
        if os_family() == "windows" {
            env("APPDATA")
        } else {
            join(home_directory(), ".config")
        }
    }

XDG_DATA_HOME := \
    if env("XDG_DATA_HOME", "") != "" {env("XDG_DATA_HOME", "")} \
    else {
        if os_family() == "windows" {
            env("LOCALAPPDATA", "")
        } else {
            join(home_directory(), ".local/share")
        }
    }

XDG_STATE_HOME := \
    if env("XDG_STATE_HOME", "") != "" {env("XDG_STATE_HOME", "")} \
    else {
        if os_family() == "windows" {
            join(env("LOCALAPPDATA", ""), "state")
        } else {
            join(home_directory(), ".local/state")
        }
    }
