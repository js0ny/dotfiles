{pkgs, ...}: {
  users.users.guest = {
    isNormalUser = true;
    description = "Guest user";
    home = "/home/guest";
    extraGroups = [""]; # 可选，是否允许 sudo
    shell = pkgs.bash;
    # hashedPassword = ""; # 空密码，意味着需要手动设置或禁用登录
    # 或者直接禁止密码登录：
    hashedPassword = null;
  };

  systemd.services."guest-reset-home" = {
    description = "Reset guest home directory on boot";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        rm -rf /home/guest/*
        cp -r /etc/skel/. /home/guest/
        chown -R guest:guest /home/guest
      '';
    };
  };
}
