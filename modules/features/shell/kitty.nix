{
  flake.modules.nixos.kitty = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.my.fonts) size;
  in {
    environment.systemPackages = [pkgs.kitty];
    hj.files.".config/kitty/kitty.conf" = {
      text = ''
        include ~/.config/kitty/current-theme.conf
        shell_integration no-rc

        enable_audio_bell no
        font_size ${toString size}

        shell ${lib.getExe pkgs.fish}

        window_margin_width 5
        clear_all_shortcuts yes
        map ctrl+shift+equal change_font_size all +2.0
        map ctrl+shift+plus change_font_size all +2.0
        map ctrl+shift+minus change_font_size all -2.0
        map ctrl+shift+kp_subtract change_font_size all -2.0

        clear_all_shortcuts yes
        map ctrl+shift+equal change_font_size all +2.0
        map ctrl+shift+plus change_font_size all +2.0
        map ctrl+shift+minus change_font_size all -2.0
        map ctrl+shift+kp_subtract change_font_size all -2.0

      '';
    };
  };
}
