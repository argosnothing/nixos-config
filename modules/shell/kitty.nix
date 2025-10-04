{
  pkgs,
  config,
  settings,
  lib,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
in {
  options.my.modules.shell.kitty = {
    enable = lib.mkEnableOption "Kitty";
  };
  config = lib.mkIf config.my.modules.shell.kitty.enable {
    environment.systemPackages = with pkgs; [kitty];
    hjem.users.${settings.username} = {
      packages = with pkgs; [
        #kitty
      ];
      files = {
        ".config/kitty/kitty.conf".text = ''
          # themes
          include stylix.conf
          #include Wryan.conf
          #include VSCode_Dark.conf

          # terminal opacity and blur
          background_opacity 1.0
          background_blur 1

          # advance
          term xterm-kitty

          # terminal bell
          enable_audio_bell no

          # os specific tweaks (Gnome window decoration for wayland)
          linux_display_server x11


          # font size management
          map ctrl+shift+backspace change_font_size all 0

          # cursor customization
          # block / beam / underline
          cursor_shape block
          cursor_blink_interval 0
          cursor_stop_blinking_after 0
          shell_integration no-cursor

          # scrollback
          scrollback_lines 5000
          wheel_scroll_multiplier 3.0

          # mouse
          mouse_hide_wait -1

          # window layout
          remember_window_size  no
          initial_window_width  1200
          initial_window_height 750
          window_border_width 1.5pt
          enabled_layouts tall
          window_padding_width 0
          window_margin_width 2
          hide_window_decorations no

          # window management
          map ctrl+shift+enter new_window
          map ctrl+shift+] next_window
          map ctrl+shift+[ previous_window

          # layout management
          map ctrl+shift+l next_layout
          map ctrl+alt+r goto_layout tall
          map ctrl+alt+s goto_layout stack

          # tab bar customization
          tab_bar_style powerline
          tab_powerline_style slanted
          tab_bar_edge bottom
          tab_bar_align left
          active_tab_font_style   bold
          inactive_tab_font_style normal

          # tab management
          map ctrl+shift+t new_tab
          map ctrl+shift+right next_tab
          map ctrl+shift+left previous_tab
          map ctrl+shift+q close_tab
        '';
        ".config/kitty/stylix.conf".text = ''
          # Selection Colors
          selection_foreground     ${c.base0E}
          selection_background     ${c.base00}

          # Window border Colors
          active_border_color      #8ec07c
          inactive_border_color    #665c54

          # Kitty tabs colors
          active_tab_foreground    #ebdbb2
          active_tab_background    #458588
          inactive_tab_foreground  #ebdbb2
          inactive_tab_background  #8ec07c

          # Basic color
          background               #1d2021
          foreground               #ebdbb2

          # 16 main colors
          color0                   #3c3836
          color1                   #cc241d
          color2                   #98971a
          color3                   #d79921
          color4                   #458588
          color5                   #b16286
          color6                   #689d6a
          color7                   #a89984
          color8                   #928374
          color9                   #fb4934
          color10                  #b8bb26
          color11                  #fabd2f
          color12                  #83a598
          color13                  #d3869b
          color14                  #8ec07c
          color15                  #fbf1c7

          # Cursor colors
          cursor                   #bdae93
          cursor_text_color        #665c54

          # Url color
          url_color                #458588
        '';
      };
    };
  };
}
