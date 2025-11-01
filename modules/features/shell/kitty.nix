{
  flake.modules.nixos.kitty = {config, ...}: let
    inherit (config.my.fonts) size;
  in {
    hm = {
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
