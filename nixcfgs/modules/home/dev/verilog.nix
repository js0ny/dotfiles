{pkgs, ...}: {
  home.packages = with pkgs; [
    verilator # Formatter
    iverilog # Simulator: Icarus Verilog
    gtkwave # Waveform Viewer
    picocom
  ];

  programs.zed-editor.extensions = ["verilog"];
}
