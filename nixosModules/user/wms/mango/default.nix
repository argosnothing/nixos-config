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
  l = config.lib.formats.rasi.mkLiteral;
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
          "background-color" = l c.base00;
          "foreground-color" = l c.base05;
          font = "FiraCode Nerd Font 20";
        };

        window = {
          "background-color" = l c.base00;
          border = l "2px";
          "border-color" = l c.base0E;
        };
        mainbox = {
          "background-color" = l c.base00;
          padding = l "8px";
        };

        inputbar = {
          "background-color" = l c.base00;
          "text-color" = l c.base05;
          padding = l "10px 14px";
        };

        prompt = {"text-color" = l c.base0E;};
        "case-indicator" = {"text-color" = l c.base0E;};

        listview = {
          "background-color" = l c.base00;
          lines = 12;
          border = l "0px";
          spacing = l "6px";
        };

        element = {
          "background-color" = l c.base00;
          "text-color" = l c.base05;
          border = l "0px";
          padding = l "8px 12px";
        };
        "element alternate" = {"background-color" = l c.base00;};

        "element selected" = {
          "background-color" = l c.base00;
          "text-color" = l c.base05;
          border = l "2px";
          "border-color" = l c.base0E;
          "border-radius" = l "6px";
        };

        "element-text" = {
          "background-color" = l c.base00;
          "text-color" = l c.base05;
        };
        "element-icon" = {
          "background-color" = l c.base00;
          size = l "1.3em";
        };
      };
    };
    home.packages = with pkgs; [
      pavucontrol
      swaybg
      xorg-xrdb
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
        waybar &
        echo "Xft.dpi:140" | xrdb -merge
        gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
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
