# https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm
{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchPnpmDeps,
  pnpmConfigHook,
  makeWrapper,
  nodejs_22,
  pnpm_10,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "noname";
  version = "v1.11.1";

  src = fetchFromGitHub {
    owner = "libnoname";
    repo = "noname";
    rev = finalAttrs.version;
    hash = "sha256-w4PGPH2EWNq0wJwLCQeKzV63HjZ8qyLfABvZHGP8oeI=";
  };

  pnpmRoot = ".";

  nativeBuildInputs = [
    nodejs_22
    pnpm_10
    pnpmConfigHook
    makeWrapper
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src pnpmRoot;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-1BVkAQut9KfYpduKxBuOoRtHBqh8rbywFC8VnbGCrA0=";
  };

  pnpmInstallFlags = ["--frozen-lockfile"];

  buildPhase = ''
    runHook preBuild
    pnpm -C ${finalAttrs.pnpmRoot} build:full
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/noname
    cp -r ./* $out/share/noname

    # wrapper：noname-server -> node dist/noname-server.cjs
    mkdir -p $out/bin
    makeWrapper ${nodejs_22}/bin/node $out/bin/noname-server \
      --add-flags "$out/share/noname/dist/noname-server.cjs" \
      --chdir "$out/share/noname/dist"

    runHook postInstall
  '';

  meta = with lib; {
    description = "noname (libnoname/noname) packaged from tag source; runs dist/noname-server.cjs";
    homepage = "https://github.com/libnoname/noname";
    license = licenses.gpl3Only;
    platforms = platforms.linux ++ platforms.darwin;
  };
})
