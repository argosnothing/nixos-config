{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.fonts) size;
in {
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
          font_size = size;
          window_margin_width = 10;
        };
        extraConfig = ''
          clear_all_shortcuts yes
          map ctrl+shift+equal change_font_size all +2.0
          map ctrl+shift+plus change_font_size all +2.0
          map ctrl+shift+minus change_font_size all -2.0
          map ctrl+shift+kp_subtract change_font_size all -2.0
        '';
      };
    };
  };
}
