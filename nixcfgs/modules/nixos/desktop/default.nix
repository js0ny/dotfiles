{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./gnome-keyring.nix
  ];
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  # Set your time zone.
  time.timeZone = "Europe/London";

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  security.pam.services.login.enableGnomeKeyring = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard
    libnotify
    gnome-disk-utility
  ];
  xdg.terminal-exec.enable = true;
}
