{pkgs, ...}: let
  addons = pkgs.nur.repos.rycee.firefox-addons;
in {
  # imports = [./lib.nix]; # TODO: Declarative extension permissions
  programs.firefox.profiles.default = {
    extensions.packages = with addons; [
      ublock-origin
      darkreader
      rsshub-radar
      proton-pass
      proton-vpn
      surfingkeys
      web-archives
      tampermonkey
      stylus
      foxy-gestures
      google-container
      refined-github
      downthemall
      material-icons-for-github
      single-file
      return-youtube-dislikes
      steam-database
      bilisponsorblock
      sponsorblock
      buster-captcha-solver
      protondb-for-steam
      i-dont-care-about-cookies
    ];
  };
}
