-- Markdown PKM
--[[ Installation:
cargo install --locked --git https://github.com/Feel-ix-343/markdown-oxide.git markdown-oxide
--]]
return {
  cmd = { "markdown-oxide" },
  root_markers = {
    ".obsidian",
  },
  filetypes = { "markdown" },
  settings = {
    Markdown = {
    },
  },
}
