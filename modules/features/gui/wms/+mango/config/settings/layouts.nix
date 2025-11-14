{
  flake.modules.nixos.mango = {lib, ...}: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        # layout support:
        # horizontal:tile,scroller,grid,monocle,spiral,dwindle
        # vertical:vertical_tile,vertical_scroller,vertical_grid,vertical_monocle,vertical_spiral,vertical_dwindle
        tagrule=id:1,layout_name:scroller
        tagrule=id:2,layout_name:tile
        tagrule=id:3,layout_name:tile
        tagrule=id:4,layout_name:tile
        tagrule=id:5,layout_name:tile
        tagrule=id:6,layout_name:tile
        tagrule=id:7,layout_name:tile
        tagrule=id:8,layout_name:tile
        tagrule=id:9,layout_name:tile

        # layer rule
        layerrule=animation_type_open:zoom,layer_name:rofi
        layerrule=animation_type_close:zoom,layer_name:rofi

      ''
    ];
  };
}
