{...}: {
  # See: https://consoledonottrack.com/
  environment.variables = import ../../lib/do-not-track-vars.nix;
}
