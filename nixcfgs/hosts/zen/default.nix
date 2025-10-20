{pkgs, ...}:
{
    imports = [
        ./packages.nix
        ../../modules/darwin/js0ny/brew.nix
        ../../modules/darwin/js0ny/dock.nix
        ../../modules/darwin/js0ny/system.nix
    ];
    time.timeZone = "Europe/London";
}
