{
  config,
  pkgs,
  ...
}: {
  programs.distrobox = {
    enable = true;
    containers = {
      Xilinx = {
        # Container to run Xilinx Vivado Toolchain 2022.2
        image = "ubuntu:22.04";
        additional_packages = "libncurses5-dev libtinfo5 ncurses-compat-libs lsb-release graphviz openssl xscreensaver gcc c++ xvfb xorg-dev libwebkit2gtk-4.0-37 libgtk-3-dev libgtk-4-dev libgvfsdbus gvfs libwayland-client0 libwayland-cursor0 x11-utils";
        home = "${config.home.homeDirectory}/.local/distrobox/Xilinx";
        init_hooks = [
          "sudo chown $USER:$USER /opt"
          "sudo mkdir -p /opt/Xilinx"
        ];
      };
    };
  };
  home.packages = with pkgs; [
    wmname
  ];
  xdg.desktopEntries = {
    "xilinx.vivado" = {
      name = "Xilinx Vivado 2022.2";
      type = "Application";
      terminal = false;
      exec = "distrobox enter Xilinx -- /opt/Xilinx/Vivado/2022.2/bin/vivado";
    };
    "xilinx.vitis" = {
      name = "Xilinx Vitis 2022.2";
      type = "Application";
      terminal = false;
      exec = "distrobox enter Xilinx -- bash ${config.home.homeDirectory}/.vitis-wr.sh";
    };
  };
}
