# Use XDG Base Directory Specification and its similar structure for Windows

# wget
${function:wget} = {wget --hsts-file $XDG_CACHE_HOME/wget-hsts $args}

# yarn v1
${function:yarn} = {yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config.yaml $args}
