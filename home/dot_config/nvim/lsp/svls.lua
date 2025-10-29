-- SystemVerilog
--[[ Installation
cargo install svls
--]]
return {
  cmd = { "svls" },
  filetypes = { "systemverilog", "verilog" },
  root_markers = { ".svls.toml" }
}
