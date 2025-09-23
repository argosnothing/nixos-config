# This file is going to be a mess for a bit as i configure mango
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
  styling = import ./styling.nix {inherit config;};
  tags = import ./tags.nix;
  misc = import ./misc.nix;
  c = config.lib.stylix.colors.withHashtag;
  rofi-theme = ''
    * { bg: ${c.base00}; fg: ${c.base05}; accent: ${c.base0E}; }
    window { background-color: @bg; }
    inputbar { background-color: @bg; padding: 6px 10px; }
    listview { lines: 12; }
    element { padding: 8px 12px; }
    element selected { background-color: @accent; color: @bg; }
    element-icon { size: 1.2em; }
  '';
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
    stylix.targets.rofi.enable = false;
    services.swaync.enable = true;
    programs.rofi = {
      enable = true;
      extraConfig = {
        font = "FiraCode Nerd Font 18";
        modi = "drun,run";
        show-icons = true;
        icon-theme = "Papirus";
        drun-display-format = "{name}";
      };
      theme = rofi-theme;
    };
    home.packages = with pkgs; [
      pavucontrol
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
