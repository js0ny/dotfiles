-- Bash
--[[ Installation
brew install bash-language-server
npm i -g bash-language-server
dnf install -y nodejs-bash-language-server # Fedora Linux
--]]
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
}
