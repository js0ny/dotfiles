{pkgs, ...}: let
  my-catppuccin-kde = pkgs.catppuccin-kde.override {
    flavour = [
      "mocha"
      "latte"
    ];
    accents = ["pink"];
    winDecStyles = ["classic"];
  };
in {
  home.packages = with pkgs; [
    catppuccin
    # my-catppuccin-gtk
    my-catppuccin-kde
    catppuccin-fcitx5
  ];

  catppuccin = {
    enable = false;
    flavor = "mocha";
    accent = "pink";
    zed.enable = false;
    zsh-syntax-highlighting.enable = false;
    nvim.enable = false; # Defined in lua config
  };
  stylix = {
    enable = true;
    autoEnable = true;

    fonts = {
      sansSerif = {
        package = pkgs.lxgw-neoxihei;
        name = "LXGW Neo XiHei";
      };

      serif = {
        package = pkgs.lxgw-wenkai;
        name = "LXGW WenKai";
      };

      monospace = {
        package = pkgs.maple-mono.NF-CN;
        name = "Maple Mono NF CN";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji-blob-bin;
        name = "Blobmoji";
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    icons = {
      enable = true;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    targets = {
      neovide.enable = false;
      neovim.enable = false;
      firefox = {
        profileNames = ["default"];
      };
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    image = ./wallpaper.jpg;
    polarity = "dark";
  };
}
