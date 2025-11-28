{
  flake.modules.nixos.mango = {lib, ...}: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        # DISCORD
        # Niri has kinda made me realize i don't need this stuff
        bind=SUPER,q,toggle_named_scratchpad,vesktop,none,vesktop
        windowrule=isnamedscratchpad:1,width:1280,height:800,appid:vesktop,isoverlay:1

        ## SPOTIFY
        ##bind=ALT+CTRL,s,toggle_named_scratchpad,spotify,none,spotify
        ##windowrule=isnamedscratchpad:1,width:1280,height:800,appid:spotify,isoverlay:1

        ## WEB
        bind=SUPER,e,toggle_named_scratchpad,firefox-scratchpad,none,firefox --name=firefox-scratchpad --no-remote -P firefox-scratchpad
        windowrule=isnamedscratchpad:1,width:1280,height:800,appid:firefox-scratchpad,overlay:1

        ## KITTY
        #bind=ALT,CTRL,e,toggle_named_scratchpad,kitty-scratchpad,none,kitty --app-id kitty-scratchpad
        #windowrule=isnamedscratchpad:1,width:1280,height:800,appid:kitty-scratchpad,overlay:1

        ## nemo nemo
        windowrule=isfloating:1,width:1280,height:800,appid:nemo

        ## pavu
        windowrule=isfloating:1,width:1280,height:800,appid:org.pulseaudio.pavucontrol
        #windowrule=isfloating:0,appid:Wfica
      ''
    ];
  };
}
