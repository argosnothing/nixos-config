{
  flake.modules.nixos.mango = {
    config,
    lib,
    ...
  }: let
    c = config.lib.stylix.colors;
    inherit (lib) mkAfter;
    to0x = hex: alpha: "0x${hex}${alpha}";
  in {
    my.wm.mango.settings = mkAfter [
      ''
        blur=1
        shadows=0
        border_radius=6
        no_radius_when_single=1
        no_border_when_single=1

        focused_opacity=0.98
        unfocused_opacity=0.98
        animations=1
        layer_animations=1
        tag_animation_direction=0
        animation_type_open=slide
        animation_type_close=slide
        animation_fade_in=1
        animation_fade_out=1
        animation_initial_fade=1
        zoom_end_ratio=0.92
        fadein_begin_opacity=0.0
        fadeout_begin_opacity=0.85
        animation_duration_open=140
        animation_duration_close=110
        animation_curve_open=0.46,1.0,0.29,1.0
        animation_curve_close=0.40,0.00,0.20,1.00

        new_is_master=0
        default_mfact=0.55
        default_master=1
        smartgaps=1

        scratchpad_width_ratio=0.8
        scratchpad_height_ratio=0.9

        borderpx=3
        rootcolor=${to0x c.base00 "ff"}
        bordercolor=${to0x c.base03 "ff"}
        focuscolor=${to0x c.base0D "ff"}
        maxmizescreencolor=${to0x c.base05 "ff"}
        urgentcolor=${to0x c.base08 "ff"}
        scratchpadcolor=${to0x c.base0C "ff"}
        globalcolor=${to0x c.base0E "ff"}
        overlaycolor=${to0x c.base0A "ff"}
      ''
    ];
  };
}
