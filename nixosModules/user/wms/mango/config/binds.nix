{
  lib,
  config,
  settings,
  ...
}: {
  config = lib.mkIf (config.wms.mango.enable) {
    wayland.windowManager.mango = {
      settings =
        config.wayland.windowManager.mango.settings
        + ''
          # reload config
          bind=SUPER,r,reload_config
          # menu and terminal
          bind=Alt,space,spawn,rofi -show drun
          bind=Alt,Return,spawn,kitty

          # exit
          bind=SUPER,m,quit
          bind=ALT,q,killclient,

          # switch window focus
          bind=SUPER,Tab,focusstack,next
          bind=ALT,Left,focusdir,left
          bind=ALT,Right,focusdir,right
          bind=ALT,Up,focusdir,up
          bind=ALT,Down,focusdir,down

          # swap window
          bind=SUPER+SHIFT,Up,exchange_client,up
          bind=SUPER+SHIFT,Down,exchange_client,down
          bind=SUPER+SHIFT,Left,exchange_client,left
          bind=SUPER+SHIFT,Right,exchange_client,right

          # switch window status
          bind=SUPER,g,toggleglobal,
          bind=ALT,Tab,toggleoverview,
          bind=ALT,backslash,togglefloating,
          bind=ALT,a,togglemaxmizescreen,
          bind=ALT,f,togglefullscreen,
          bind=ALT+SHIFT,f,togglefakefullscreen,
          bind=SUPER,i,minimized,
          bind=SUPER,o,toggleoverlay,
          bind=SUPER+SHIFT,I,restore_minimized
          bind=ALT,z,toggle_scratchpad

          # scroller layout
          bind=ALT,e,set_proportion,1.0
          bind=ALT,x,switch_proportion_preset,

          # switch layout
          bind=SUPER,n,switch_layout

          # tag switch
          bind=SUPER,Left,viewtoleft,0
          bind=CTRL,Left,viewtoleft_have_client,0
          bind=SUPER,Right,viewtoright,0
          bind=CTRL,Right,viewtoright_have_client,0
          bind=CTRL+SUPER,Left,tagtoleft,0
          bind=CTRL+SUPER,Right,tagtoright,0

          bind=Ctrl,1,view,1,0
          bind=Ctrl,2,view,2,0
          bind=Ctrl,3,view,3,0
          bind=Ctrl,4,view,4,0
          bind=Ctrl,5,view,5,0
          bind=Ctrl,6,view,6,0
          bind=Ctrl,7,view,7,0
          bind=Ctrl,8,view,8,0
          bind=Ctrl,9,view,9,0

          # tag: move client to the tag and focus it
          # tagsilent: move client to the tag and not focus it
          # bind=Alt,1,tagsilent,1
          bind=Alt,1,tag,1,0
          bind=Alt,2,tag,2,0
          bind=Alt,3,tag,3,0
          bind=Alt,4,tag,4,0
          bind=Alt,5,tag,5,0
          bind=Alt,6,tag,6,0
          bind=Alt,7,tag,7,0
          bind=Alt,8,tag,8,0
          bind=Alt,9,tag,9,0

          # monitor switch
          bind=alt+shift,Left,focusmon,left
          bind=alt+shift,Right,focusmon,right
          bind=SUPER+Alt,Left,tagmon,left
          bind=SUPER+Alt,Right,tagmon,right

          # gaps
          bind=ALT+SHIFT,X,incgaps,1
          bind=ALT+SHIFT,Z,incgaps,-1
          bind=ALT+SHIFT,R,togglegaps

          # adjust tile window size
          # change master fact for tile,spiral,deck,dwindle
          bind=ALT+SUPER,h,setmfact,-0.05
          bind=ALT+SUPER,l,setmfact,+0.05
          # change sub master fact for dwindle,spiral
          bind=ALT+SUPER,k,setsmfact,-0.05
          bind=ALT+SUPER,j,setsmfact,+0.05
          # change scroller proportion
          bind=ctrl+super,j,increase_proportion,0.1
          bind=ctrl+super,k,increase_proportion,-0.1

          # movewin
          bind=CTRL+SHIFT,Up,movewin,+0,-50
          bind=CTRL+SHIFT,Down,movewin,+0,+50
          bind=CTRL+SHIFT,Left,movewin,-50,+0
          bind=CTRL+SHIFT,Right,movewin,+50,+0

          # resizewin
          bind=CTRL+ALT,Up,resizewin,+0,-50
          bind=CTRL+ALT,Down,resizewin,+0,+50
          bind=CTRL+ALT,Left,resizewin,-50,+0
          bind=CTRL+ALT,Right,resizewin,+50,+0

          # Mouse Button Bindings
          # NONE mode key only work in ov mode
          mousebind=SUPER,btn_left,moveresize,curmove
          mousebind=NONE,btn_middle,togglemaxmizescreen,0
          mousebind=SUPER,btn_right,moveresize,curresize
          mousebind=NONE,btn_left,toggleoverview,-1
          mousebind=NONE,btn_right,killclient,0

          # Axis Bindings
          axisbind=SUPER,UP,viewtoleft_have_client
          axisbind=SUPER,DOWN,viewtoright_have_client
        '';
    };
  };
}
