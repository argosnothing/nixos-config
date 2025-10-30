{
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.oxwm = let
    nixos-modules = with flake.modules.nixos; [
      ly
      cursor
      icons
      gtk
      stylix
    ];
  in {
    services.xserver = {
      enable = true;
      windowManager.oxwm.enable = true;
    };
    imports =
      [inputs.oxwm.nixosModules.default]
      ++ nixos-modules;
  };
}
