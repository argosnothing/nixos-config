{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wms.mango.enable {
    home.packages = with pkgs; [waybar];
    home.file = {
      ".config/waybar/config.jsonc".source = ./config.jsonc;
      ".config/waybar/style.css".source = ./style.css;
      ".config/waybar/nord.css".source = ./nord.css;
      ".config/waybar/battery_menu.xml".source = ./battery_menu.xml;
    };
  };
}
