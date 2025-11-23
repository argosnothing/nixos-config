{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.labwc = {config, ...}: let
    inherit (config.my) desktop-shells;
  in {
    services = {
      desktopManager = {
        xfce = {
          waylandSessionCompositor = "labwc";
        };
      };
    };
    #hj.files = {
    #  ".config/labwc/autostart".text = ''
    #    #${desktop-shells.execCommand} &
    #  '';
    #};
    imports = with flake.modules.nixos; [
      wm
      icons
      gtk
      cursor
      sddm-silent
      rose-pine
      dms
    ];
    my.cursor.enable = true;
    programs.labwc.enable = true;
  };
}
