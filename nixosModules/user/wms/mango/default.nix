{
  pkgs,
  config,
  lib,
  settings,
  ...
}: let
  binds = ./binds.nix;
  monitors = ./monitors.nix;
  inputs = ./inputs.nix;
  layouts = ./layouts.nix;
  overview = ./overview.nix;
  scratchpads = ./scratchpads.nix;
  styling = ./styling.nix;
  tags = ./tags.nix;
  misc = ./misc.nix;
in {
  imports = [
    ./config
    inputs.mango.hmModules.mango
  ];
  options = {
    wms.mango.enable = lib.mkEnableOption "Enable Mango";
  };
  config = lib.mkIf (config.custom.wm.name == "mango") {
    wms.mango.enable = true;
    styles.stylix.enable = true;
    home.packages = with pkgs; [
      rofi
      swaybg
      (pkgs.writeShellScriptBin "setbg"
        ''
          swaybg -m stretch -i ${settings.absoluteflakedir}/media/current-wallpaper.jpg
        '')
    ];
    wayland.windowManager.mango = {
      enable = true;
      autostart_sh = ''
        set +e
        setbg &
        waybar
      '';
      settings =
        binds
        + monitors
        + inputs
        + layouts
        + overview
        + scratchpads
        + styling
        + tags
        + misc;
    };
  };
}
