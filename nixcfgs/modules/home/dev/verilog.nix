{pkgs, ...}: {
  home.packages = with pkgs; [
    verilator # Formatter
    iverilog # Simulator: Icarus Verilog
    gtkwave # Waveform Viewer
  ];

  programs.zed-editor.extensions = ["verilog"];
}
