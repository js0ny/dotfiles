# pip
alias pip=pip3
alias python=python3
python -m pip install --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# npm
npm config set registry https://registry.npmmirror.com



# Linuxbrew
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

# 注：自 brew 4.0 起，使用默认 prefix (即 "/home/linuxbrew/.linuxbrew") 的大部分 Homebrew 用户无需设置 homebrew/core 镜像，只需设置 HOMEBREW_API_DOMAIN 即可。
# 如果不是默认 prefix 或者需要使用 Homebrew 的开发命令 (如 `brew cat <formula>`)，则仍然需要设置 homebrew/core 镜像。
# 请按需执行如下命令：
brew tap --custom-remote --force-auto-update homebrew/core https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

# 除 homebrew/core 仓库外的 tap 仓库仍然需要设置镜像
brew tap --custom-remote --force-auto-update homebrew/command-not-found https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-command-not-found.git
brew tap --custom-remote --force-auto-update homebrew/services https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-services.git
brew update
