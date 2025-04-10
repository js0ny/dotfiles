-- Beancount
--[[ Installation:
Dependency:
uv tool install beancount
LSP:
cargo install beancount-language-server
brew install beancount-language-server
--]]


return {
  cmd = { "beancount-language-server" },
  filetypes = { "beancount" },
  settings = {
  },
}
