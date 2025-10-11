{pkgs, ...}: {
  programs.chromium = {
    extraOpts = {
      "BrowserSignin" = 0;
      "PasswordManagerEnabled" = false;
    };
  };
}
