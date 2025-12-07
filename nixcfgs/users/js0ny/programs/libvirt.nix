{pkgs, ...}: let
  virt-manager-view-fzf = pkgs.writeShellScriptBin "virt-manager-view-fzf" ''
    #!/usr/bin/env bash

    VM=$(virsh --connect qemu:///system list --name --state-running | sed '/^$/d' | fzf --height=20% --border --prompt="Select VM > ")

    if [ -n "$VM" ]; then
        echo "Opening console for $VM..."
        virt-manager --connect qemu:///system --show-domain-console "$VM" &>/dev/null &
    else
        echo "No VM selected."
    fi
  '';
  devs = [
    "0bda:9210" # Realtek Semiconductor Corp. RTL9210 M.2 NVME Adapter
  ];
in {
  home.packages = with pkgs; [
    virt-manager-view-fzf
    remmina
  ];

  xdg.configFile."libvirt/libvirt.conf" = {
    text = ''uri_default = "qemu:///system"'';
    enable = true;
  };

  dconf.settings = {
    "org/virt-manager/virt-manager" = {
      xmleditor-enabled = true;
      firmware = "uefi";
    };
    "org/virt-manager/virt-manager/console" = {
      "grab-keys" = "65513,65507";
    };
  };
}
