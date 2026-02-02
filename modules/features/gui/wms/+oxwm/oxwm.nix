{
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.oxwm = {pkgs, ...}: let
    nixos-modules = with flake.modules.nixos; [
      ly
      icons
      gtk
    ];
  in {
    environment.systemPackages = with pkgs; [
      dmenu
      oxwm
    ];
    imports = nixos-modules;
    services.xserver = {
      enable = true;
      windowManager.oxwm = {
        enable = true;
        package = inputs.oxwm.packages.${pkgs.system}.default;
      };
    };
    my.persist.home.directories = [".config/oxwm"];
  };
}
