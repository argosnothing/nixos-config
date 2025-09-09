{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    ./config
    ../../ricing
  ];
  options = {
    wms.niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri Wayland compositor.";
    };
  };
  config = lib.mkIf config.wms.niri.enable {
    noctalia-shell.enable = true;
    programs.niri.enable = true;
    programs.niri.settings.debug = {
      wait-for-frame-completion-before-queueing = [];
    };
  };
}
