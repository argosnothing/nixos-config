{
  flake.modules.nixos.mango = {lib, ...}: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        scroller_status=1
        scroller_default_proportion=0.333
        scroller_focus_center=0
        scroller_prefer_center=0
        edge_scroller_pointer_focus=1
        scroller_structs=0
        scroller_default_proportion_single=1.0
        scroller_proportion_preset=0.333,0.5,1.0
      ''
    ];
  };
}
