{pkgs}: {
  home.packages = with pkgs; [
    verilator # Formatter
    iverilog # Simulator: Icarus Verilog
    gtkwave # Waveform Viewer
    vimPlugins.nvim-treesitter-parsers.verilog
  ];

  programs.zed-editor.extensions = ["verilog"];
}
