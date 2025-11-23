{config, ...}:let
  inherit (config) flake;
in{
  flake.modules.nixos.labwc = {config, ...}: let
    inherit (config.my) desktop-shells;
  in {
    hj.files = {
      ".config/labwc/autostart".text = ''
        ${desktop-shells.execCommand} &
      '';
    };
    imports = with flake.modules.nixos; [
      sddm-silent
      rose-pine
      dms
    ];
    programs.labwc.enable = true;
    wayland.windowManager = {
      labwc = {
        enable = true;
      };
    };
  };
}
