{
  flake.modules.nixos.mango = {lib, ...}: let
    inherit (lib) mkAfter;
  in {
    my.wm.mango.settings = mkAfter [
      ''
        blur=1
        shadows=0
        border_radius=0
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
      ''
    ];
  };
}
