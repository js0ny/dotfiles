{...}: {
  imports = [
    ./vimrc-support.nix
  ];
  programs.obsidian = {
    enable = true;
    vaults."HomeManagerDryRun" = {
      enable = true;
      target = "HomeManagerDryRun"; # relative to $HOME
      settings = {
      };
    };
  };
}
