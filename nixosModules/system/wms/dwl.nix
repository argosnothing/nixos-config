### MASSIVE WIP FILE DO NOT LOOK
###
###
{
  pkgs,
  lib,
  config,
  inputs,
  settings,
  ...
}: let
  colors = config.lib.stylix.colors;
in {
  options = {
    wms.dwl.enable = lib.mkEnableOption "Enable System DWL Session";
  };

  config = lib.mkIf (config.custom.wm.name == "dwl") {
    wms.dwl.enable = true;
    styles.stylix.enable = true;
    custom.greeters.tuigreet = {
      enable = true;
      run-command = "dwlwbar";
    };
    environment.systemPackages = with pkgs; [
      dwlb
      wl-clipboard
      grim
      slurp
      wf-recorder
      somebar
      (pkgs.writeShellScriptBin
        "dwlb-stylix"
        ''
          dwlb \
            -font "${config.stylix.fonts.monospace.name}:size=14" \
            -active-fg-color   '${colors.base0E}' \
            -active-bg-color   '${colors.base00}' \
            -occupied-fg-color '${colors.base0D}' \
            -occupied-bg-color '${colors.base00}' \
            -inactive-fg-color '${colors.base04}' \
            -inactive-bg-color '${colors.base00}' \
            -urgent-fg-color   '${colors.base08}' \
            -urgent-bg-color   '${colors.base00}' \
            -middle-bg-color           '${colors.base00}' \
            -middle-bg-color-selected  '${colors.base00}' \
            "$@"
        '')
      (pkgs.writeShellScriptBin
        "snip"
        ''
          ${pkgs.grim}/bin/grim -l 0 -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
        '')
      (pkgs.writeShellScriptBin
        "dwlwbar"
        ''
          dwl -s 'dwlb-stylix'
        '')

      #dwl -s 'dwlb -font "sans:size=16"'
    ];
    programs.dwl = {
      enable = true;
      package = pkgs.dwl.overrideAttrs (next: prev: {
        src = inputs.dwl;
        buildInputs =
          prev.buildInputs
          ++ [
            pkgs.wlroots_0_19
            pkgs.libxcb
            pkgs.libxcb-wm
            pkgs.wlr
            pkgs.xwayland-run
          ];
      });
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
    };
    services = {
      xserver.excludePackages = [pkgs.xterm];
    };
  };
}
