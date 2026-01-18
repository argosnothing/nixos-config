# Stuff I generally want to have on for my shells
{config, ...}: let
  inherit (config) flake;
  inherit (flake.lib) move-script;
in {
  flake.modules.nixos.shell-apps = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      copilot-cli
      yazi
      helix
      kitty
      fish
      nh
      git
      stow
      misc-scripts
      starship
      fetch
      build-iso
    ];
  in {
    environment.systemPackages = move-script {
      inherit pkgs;
      targetPath = ".config/scripts";
    };
    imports = nixos-modules;
  };
}
