{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.mango.hmModules.mango];
  options = {
    wms.mango.enable = lib.mkEnableption "Enable Mango";
  };
  config = lib.mkIf (config.custom.wm.name == "mango") {
    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        bind=Alt,Return,spawn,kitty
      '';
    };
  };
}
