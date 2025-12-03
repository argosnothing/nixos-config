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
    my.persist.home.directories = [".config/kitty"];
    hj.files.".config/kitty/kitty.conf" = {
      text = ''
        include ~/.config/kitty/current-theme.conf
        shell_integration no-rc
        enable_audio_bell no
        font_size ${toString size}
        shell ${lib.getExe pkgs.fish}
        window_margin_width 5
        enabled_layouts splits:split_axis=horizontal
        map ctrl+shift+j neighboring_window down
        map ctrl+shift+k neighboring_window up
        map ctrl+shift+h neighboring_window left
        map ctrl+shift+l neighboring_window right
        map ctrl+shift+alt+j move_window down
        map ctrl+shift+alt+k move_window up
        map ctrl+shift+alt+h move_window left
        map ctrl+shift+alt+l move_window right
        map ctrl+shift+n launch --cwd=current --type=os-window
        map ctrl+shift+enter launch --cwd=current --type=window --location=split
        map ctrl+shift+s launch --cwd=current --location=hsplit
        map ctrl+shift+v launch --cwd=current --location=vsplit
      '';
    };
  };
}
