{
  pkgs,
  config,
  lib,
  settings,
  inputs,
  ...
}: let
  binds = import ./binds.nix;
  monitors = import ./monitors.nix;
  mango-inputs = import ./inputs.nix;
  layouts = import ./layouts.nix;
  overview = import ./overview.nix;
  scratchpads = import ./scratchpads.nix;
  styling = import ./styling.nix;
  tags = import ./tags.nix;
  misc = import ./misc.nix;
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
        + mango-inputs
        + layouts
        + overview
        + scratchpads
        + styling
        + tags
        + misc;
    };
  };
}
