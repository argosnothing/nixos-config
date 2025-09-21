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
      (pkgs.writeShellScriptBin
        "dwlb-stylix"
        ''
          dwlb \
             -font "${mono}:size=14" \
             -vertical-padding 6 \
             \
             # keep bar background flat
             -active-bg-color  '${c.base00}' \
             -occupied-bg-color '${c.base00}' \
             -inactive-bg-color '${c.base00}' \
             -urgent-bg-color   '${c.base00}' \
             \
             # accents
             -active-fg-color   '${c.base0D}'  \  # blue for active tag
             -occupied-fg-color '${c.base0A}'  \  # yellow for occupied
             -inactive-fg-color '${c.base03}'  \  # subtle gray
             -urgent-fg-color   '${c.base08}'  \  # red for urgent
             \
             # status (middle) background SAME as bar to remove the “block”
             -middle-bg-color           '${c.base00}' \
             -middle-bg-color-selected  '${c.base00}' \
             \
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
        buildInputs = prev.buildInputs ++ [pkgs.wlroots_0_19];
      });
    };
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    services = {
      xserver.excludePackages = [pkgs.xterm];
    };
  };
}
