{
  pkgs,
  config,
  settings,
  lib,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
  l = config.lib.formats.rasi.mkLiteral;
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  config = lib.mkIf config.wms.mango.enable {
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
  };
}
