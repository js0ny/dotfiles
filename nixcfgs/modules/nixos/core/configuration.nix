{
  config,
  pkgs,
  ...
}: {
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocales = [
      "en_GB.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      # LC_CTYPE = "en_GB.UTF-8";
      LC_ALL = "en_GB.UTF-8";
    };
  };

  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixcfgs";
  };

  # system.copySystemConfiguration = true;
  nix.settings = {
    trusted-users = ["js0ny" "root"];
    use-xdg-base-directories = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.js0ny = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJToUo2jT3qt7eHIME9e1awabZZVmtKhbxwVz9BMSM2d js0ny@zephyrus"
    ];
    shell = pkgs.zsh;
  };
  programs.command-not-found.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/js0ny/.dotfiles/nixcfgs";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
