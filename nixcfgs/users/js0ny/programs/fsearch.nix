{
  pkgs,
  lib,
  config,
  ...
}: let
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergeIni = mergetools.mkMergedIni;
  # username = config.home.username;
  fsearchConf = mkMergeIni {
    name = "fsearch-conf";
    target = ".config/fsearch/fsearch.conf";
    settings = {
      Interface = {
        single_click_open = false;
        launch_desktop_files = true;
        highlight_search_terms = true;
        double_click_path = false;
        enable_list_tooltips = true;
        enable_dark_theme = true;
        show_menubar = true;
        show_statusbar = true;
        show_filter = true;
      };
      Search = {
        search_as_you_type = true;
        auto_search_in_path = true;
        hide_results_on_empty_search = true;
      };
      Database = {
        update_database_on_launch = true;
        update_database_every = false;
        update_database_every_hours = 0;
        update_database_every_minutes = 15;
        exclude_hidden_files_and_folders = false;
        follow_symbolic_links = false;
        exclude_location_1 = "/proc";
        exclude_location_enabled_1 = true;
        exclude_location_2 = "/sys";
        exclude_location_enabled_2 = true;
        exclude_location_3 = "/nix";
        exclude_location_enabled_3 = true;
        exclude_location_4 = "/tmp";
        exclude_location_enabled_4 = true;
        exclude_files = ".git;.Xil;.filen_trash_local;.direnv;.devcontainer;.cache;.bin;.github;.idea*;.bak;.history;.metadata;.jj;.jobs;node_modules;.log;.gradle;.fingerprint;.filen.trash.local;.settings;.vscode;__pycache__;xwechat_files;SiYuan;.trash;.obsidian;.project;.cproject;.gitignore;*.mk;*.o;*.d;*.checksum;*.bit;top.mmi;*.elf;*.log;impl_1;*.cache;*.runs;*.sim;hw.xml;*.hw;*.ip_user_files;*.runs;vivado.jou;vivado.log;vivado*.jou;vivado*.log;utils_1";
      };
    };
  };
in {
  imports = [fsearchConf];
  home.packages = with pkgs; [
    fsearch
  ];
}
