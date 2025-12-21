{
  config,
  pkgs,
  ...
}: let
  xilinxBoxHome = "${config.home.homeDirectory}/.local/distrobox/Xilinx";
  vivadoLauncher = version:
    pkgs.writeShellScriptBin "vivado-launcher-${version}" ''
      #!${pkgs.stdenv.shell}
      ${pkgs.wmname}/bin/wmname LG3D

      CACHE="${config.xdg.cacheHome}/vivado"
      mkdir -p "$CACHE"

      exec ${pkgs.distrobox}/bin/distrobox enter Xilinx -- /opt/Xilinx/Vivado/${version}/bin/vivado \
        -log "$CACHE/vivado.log" \
        -journal "$CACHE/vivado.jou" \
        "$@"
    '';
  # Do not launch 2015 and 2022 simultaneously to avoid conflicts
  vivadoLauncher2022 = vivadoLauncher "2022.2";
  vivadoLauncher2015 = vivadoLauncher "2015.2";
in {
  programs.distrobox = {
    enable = true;
    containers = {
      Xilinx = {
        # Container to run Xilinx Vivado Toolchain 2022.2
        image = "ubuntu:22.04";
        additional_packages = "libncurses5-dev libtinfo5 ncurses-compat-libs lsb-release graphviz openssl xscreensaver gcc c++ xvfb xorg-dev libwebkit2gtk-4.0-37 libgtk-3-dev libgtk-4-dev libgvfsdbus gvfs libwayland-client0 libwayland-cursor0 x11-utils bear";
        home = xilinxBoxHome;
        init_hooks = [
          "sudo chown $USER:$USER /opt"
          "sudo mkdir -p /opt/Xilinx"
          "echo 'source /opt/Xilinx/Vivado/2022.2/settings64.sh' >> ${xilinxBoxHome}/.bashrc"
          "echo 'source /opt/Xilinx/Vitis/2022.2/settings64.sh' >> ${xilinxBoxHome}/.bashrc"
          # "echo 'alias vitis=\"${xilinxBoxHome}/.vitis-wr.sh\"' >> ${xilinxBoxHome}/.bashrc"
        ];
      };
    };
  };
  home.packages = with pkgs; [
    wmname
  ];
  home.file = {
    "${xilinxBoxHome}/.vitis-wr.sh" = {
      text = ''
        #!/bin/bash
        # ~/.vitis-wr.sh

        unset LD_LIBRARY_PATH
        unset GIO_MODULE_DIR
        unset XDG_DATA_DIRS

        exec /opt/Xilinx/Vitis/2022.2/bin/vitis "$@"
      '';
      executable = true;
      enable = true;
    };
    # Redirect Vivado log and journal files to /tmp to avoid filling up the cwd
    # Note: Untested
    "${xilinxBoxHome}/.Xilinx/Vivado/Vivado_init.tcl" = {
      enable = true;
      # set_param general.journaldir /tmp
      text = ''
        set_param general.logdir /tmp
      '';
    };
  };
  xdg.desktopEntries = {
    "xilinx.vivado" = {
      name = "Xilinx Vivado 2022.2";
      type = "Application";
      terminal = false;
      icon = "vivado_logo";
      categories = ["Development"];
      exec = "${vivadoLauncher2022}/bin/vivado-launcher-2022.2";
    };
    "xilinx.vivado.2015" = {
      name = "Xilinx Vivado 2015.2";
      type = "Application";
      terminal = false;
      icon = "vivado_logo";
      categories = ["Development"];
      exec = "${vivadoLauncher2015}/bin/vivado-launcher-2015.2";
    };
    "xilinx.vitis" = {
      name = "Xilinx Vitis 2022.2";
      type = "Application";
      terminal = false;
      icon = "vivado_logo";
      categories = ["Development"];
      exec = "env GDK_BACKEND=x11 distrobox enter Xilinx -- bash ${xilinxBoxHome}/.vitis-wr.sh";
    };
  };
}
