{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    ../../ricing/quickshell
    ./wofi.nix
    ./config
  ];
  options = {
    wms.niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri Wayland compositor.";
    };
  };
  config = lib.mkIf config.wms.niri.enable {
    noctalia.enable = true;  # Enable Noctalia Shell instead of basic QuickShell
    yazi.enable = true;
    programs.niri.enable = true;
  };
}
