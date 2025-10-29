{pkgs, ...}: {
  home.packages = with pkgs; [
    verilator # Formatter
    iverilog # Simulator: Icarus Verilog
    gtkwave # Waveform Viewer
    picocom
    verible # LSP
    svls # LSP
  ];

  programs.zed-editor.extensions = ["verilog"];
}
