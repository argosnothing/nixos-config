{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./config
  ];
  options = {
    wms.niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri Wayland compositor.";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "niri") {
    wms.niri.enable = true;
    custom.desktop-shell.name = "noctalia-shell";
    programs.niri.enable = true;
    programs.niri.settings.debug = {
      wait-for-frame-completion-before-queueing = [];
    };
  };
}
