{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.my.modules.gui.wms.mango.enable {
    hm = _: {
      programs.rofi = {
        enable = true;
      };
    };
  };
}
