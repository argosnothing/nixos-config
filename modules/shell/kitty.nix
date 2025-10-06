{
  config,
  lib,
  ...
}: {
  options.my.modules.shell.kitty = {
    enable = lib.mkEnableOption "Kitty";
  };
  config = lib.mkIf config.my.modules.shell.kitty.enable {
    hm = _: {
      programs.kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        settings = {
          enable_audio_bell = false;
        };
      };
    };
  };
}
