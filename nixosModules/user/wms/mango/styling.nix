{config, ...}: let
  c = config.lib.stylix.colors;
  to0x = hex: alpha: "0x${hex}${alpha}";
in ''
  blur=0
  shadows=0
  border_radius=0
  no_radius_when_single=0
  focused_opacity=0.98
  unfocused_opacity=0.98

  animations=1
  layer_animations=1
  tag_animation_direction=1
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

  scroller_status=1
  scroller_default_proportion=0.80
  scroller_focus_center=0
  scroller_prefer_center=0
  edge_scroller_pointer_focus=1
  scroller_default_proportion_single=1.00
  scroller_proportion_preset=0.5,0.8,1.0

  new_is_master=1
  default_mfact=0.55
  default_master=1
  smartgaps=0

  gappih=5
  gappiv=5
  gapoh=10
  gapov=10
  scratchpad_width_ratio=0.8
  scratchpad_height_ratio=0.9
  borderpx=3

  rootcolor=${to0x c.base00 "ff"}
  bordercolor=${to0x c.base03 "ff"}
  focuscolor=${to0x c.base0E "ff"}
  maxmizescreencolor=${to0x c.base0D "ff"}
  urgentcolor=${to0x c.base08 "ff"}
  scratchpadcolor=${to0x c.base03 "ff"}
  globalcolor=${to0x c.base03 "ff"}
  overlaycolor=${to0x c.base0F "ff"}
''
