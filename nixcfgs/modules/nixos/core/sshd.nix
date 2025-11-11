{...}: {
  services.openssh = {
    enable = true;
    settings = {
      UseDns = true;
      PermitRootLogin = "no";
      # PasswordAuthentication = true;
      # This is default to true, make sure override it when needed.
    };
  };
}
