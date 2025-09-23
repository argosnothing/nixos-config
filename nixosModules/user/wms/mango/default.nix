{
  pkgs,
  config,
  lib,
  inputs,
  settings,
  ...
}: let
  binds = import ./binds.nix {};
in {
  imports = [
    ./config
    inputs.mango.hmModules.mango
  ];
  options = {
    wms.mango.enable = lib.mkEnableOption "Enable Mango";
  };
  config = lib.mkIf (config.custom.wm.name == "mango") {
    wms.mango.enable = true;
    styles.stylix.enable = true;
    home.packages = with pkgs; [
      rofi
      swaybg
      (pkgs.writeShellScriptBin "setbg"
        ''
          swaybg -m stretch -i ${settings.absoluteflakedir}/media/current-wallpaper.jpg
        '')
    ];
    wayland.windowManager.mango = {
      enable = true;
      autostart_sh = ''
        set +e
        setbg &
        waybar
      '';
      settings =
        ''
          # More option see https://github.com/DreamMaoMao/mango/wiki/

          monitorrule=DP-1,0.55,1,tile,0,1,0,0,3840,2160,144
          monitorrule=DP-2,0.55,1,tile,0,1,3840,288,1920,1080,60
          # Window effect
          blur=0
          blur_layer=0
          blur_optimized=1
          blur_params_num_passes = 2
          blur_params_radius = 5
          blur_params_noise = 0.02
          blur_params_brightness = 0.9
          blur_params_contrast = 0.9
          blur_params_saturation = 1.2

          shadows = 0
          layer_shadows = 0
          shadow_only_floating = 1
          shadows_size = 10
          shadows_blur = 15
          shadows_position_x = 0
          shadows_position_y = 0
          shadowscolor= 0x000000ff

          border_radius=6
          no_radius_when_single=0
          focused_opacity=1.0
          unfocused_opacity=1.0

          # Animation Configuration(support type:zoom,slide)
          # tag_animation_direction: 0-horizontal,1-vertical
          animations=1
          layer_animations=1
          animation_type_open=slide
          animation_type_close=slide
          animation_fade_in=1
          animation_fade_out=1
          tag_animation_direction=1
          zoom_initial_ratio=0.3
          zoom_end_ratio=0.8
          fadein_begin_opacity=0.5
          fadeout_begin_opacity=0.8
          animation_duration_move=500
          animation_duration_open=400
          animation_duration_tag=350
          animation_duration_close=800
          animation_curve_open=0.46,1.0,0.29,1
          animation_curve_move=0.46,1.0,0.29,1
          animation_curve_tag=0.46,1.0,0.29,1
          animation_curve_close=0.08,0.92,0,1

          # Scroller Layout Setting
          scroller_structs=20
          scroller_default_proportion=0.8
          scroller_focus_center=0
          scroller_prefer_center=0
          edge_scroller_pointer_focus=1
          scroller_default_proportion_single=1.0
          scroller_proportion_preset=0.5,0.8,1.0

          # Master-Stack Layout Setting (tile,spiral,dwindle)
          new_is_master=1
          default_mfact=0.55
          default_nmaster=1
          smartgaps=0

          # Overview Setting
          hotarea_size=10
          enable_hotarea=1
          ov_tab_mode=0
          overviewgappi=5
          overviewgappo=30

          # Misc
          no_border_when_single=0
          axis_bind_apply_timeout=100
          focus_on_activate=1
          inhibit_regardless_of_visibility=0
          sloppyfocus=1
          warpcursor=1
          focus_cross_monitor=0
          focus_cross_tag=0
          enable_floating_snap=0
          snap_distance=30
          cursor_size=24
          drag_tile_to_tile=1

          # keyboard
          repeat_rate=25
          repeat_delay=600
          numlockon=1
          xkb_rules_layout=us

          # Trackpad
          # need relogin to make it apply
          disable_trackpad=0
          tap_to_click=1
          tap_and_drag=1
          drag_lock=1
          trackpad_natural_scrolling=0
          disable_while_typing=1
          left_handed=0
          middle_button_emulation=0
          swipe_min_threshold=1

          # mouse
          # need relogin to make it apply
          mouse_natural_scrolling=0

          # Appearance
          gappih=5
          gappiv=5
          gappoh=10
          gappov=10
          scratchpad_width_ratio=0.8
          scratchpad_height_ratio=0.9
          borderpx=4
          rootcolor=0x201b14ff
          bordercolor=0x444444ff
          focuscolor=0xc9b890ff
          maxmizescreencolor=0x89aa61ff
          urgentcolor=0xad401fff
          scratchpadcolor=0x516c93ff
          globalcolor=0xb153a7ff
          overlaycolor=0x14a57cff

          # layout support:
          # horizontal:tile,scroller,grid,monocle,spiral,dwindle
          # vertical:vertical_tile,vertical_scroller,vertical_grid,vertical_monocle,vertical_spiral,vertical_dwindle
          tagrule=id:1,layout_name:tile
          tagrule=id:2,layout_name:tile
          tagrule=id:3,layout_name:tile
          tagrule=id:4,layout_name:tile
          tagrule=id:5,layout_name:tile
          tagrule=id:6,layout_name:tile
          tagrule=id:7,layout_name:tile
          tagrule=id:8,layout_name:tile
          tagrule=id:9,layout_name:tile

          # Key Bindings
          # key name refer to `xev` or `wev` command output,
          # mod keys name: super,ctrl,alt,shift,none



          # layer rule
          layerrule=animation_type_open:zoom,layer_name:rofi
          layerrule=animation_type_close:zoom,layer_name:rofi
        ''
        + binds;
    };
  };
}
