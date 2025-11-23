{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.labwc = {config, ...}: let
    inherit (config.my) desktop-shells;
  in {
    hj.files = {
      ".config/labwc/autostart".text = ''
        ${desktop-shells.execCommand} &
      '';
    };
    imports = with flake.modules.nixos; [
      wm
      icons
      gtk
      cursor
    ];
    my.cursor.enable = true;
    programs.labwc.enable = true;
  };
}
