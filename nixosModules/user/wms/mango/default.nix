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
  inherit (config.lib.formats.rasi) mkLiteral;
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

      theme = {
        "*" = {
          background = mkLiteral c.base00;
          foreground = mkLiteral c.base05;
          accent = mkLiteral c.base0E;
          font = mkLiteral "FiraCode Nerd Font 20";
        };

        window = {
          "background-color" = mkLiteral "@background";
          border = 0;
        };
        mainbox = {
          "background-color" = mkLiteral "@background";
          padding = mkLiteral "8px";
        };
        inputbar = {
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
          padding = mkLiteral "10px 14px";
        };
        prompt = {
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
        };
        entry = {
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
        };

        listview = {
          "background-color" = mkLiteral "@background";
          lines = 12;
        };
        element = {
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
          padding = mkLiteral "8px 12px";
        };
        "element-icon" = {size = mkLiteral "1.3em";};
        "element-text" = {"text-color" = mkLiteral "@foreground";};
        "element selected" = {
          "background-color" = mkLiteral "@accent";
          "text-color" = mkLiteral "@background";
        };
      };
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
