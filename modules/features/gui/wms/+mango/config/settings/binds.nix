{
  flake.modules.nixos.mango = {
    lib,
    config,
    ...
  }: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        # reload config
        bind=SUPER+SHIFT,r,reload_config
        # menu and terminal
        bind=SUPER+CTRL+SHIFT,s,spawn,snip
        #bind=SUPER+CTRL,v,spawn,record-region-start
        #bind=SUPER+CTRL+SHIFT,v,spawn,record-region-stop
        bind=SUPER,space,spawn,${config.my.desktop-shells.launcherCommand}
        bind=SUPER,Return,spawn,kitty

        # exit
        bind=SUPER,Escape,killclient,

        # switch window focus
        bind=SUPER,Left,focusdir,left
        bind=SUPER,Right,focusdir,right
        bind=SUPER,Up,focusdir,up
        bind=SUPER,Down,focusdir,down

        bind=SUPER,h,focusdir,left
        bind=SUPER,l,focusdir,right
        bind=SUPER,k,focusdir,up
        bind=SUPER,j,focusdir,down

        # swap window
        # bind=SUPER+SHIFT,j,exchange_stack_client,next
        # bind=SUPER+SHIFT,k,exchange_stack_client,prev
        bind=SUPER+CTRL,k,exchange_client,up
        bind=SUPER+CTRL,j,exchange_client,down
        bind=SUPER+CTRL,h,exchange_client,left
        bind=SUPER+CTRL,l,exchange_client,right

        # switch window status
        bind=SUPER,backslash,togglefloating,
        bind=SUPER,f,togglefullscreen,
        #bind=SUPER,f,set_proportion,1.0
        bind=SUPER,o,toggleoverlay,

        # scroller layout
        bind=SUPER,r,switch_proportion_preset,

        # switch layout
        bind=SUPER+SHIFT,Return,zoom
        bind=SUPER,code:20,incnmaster,-1
        bind=SUPER,code:21,incnmaster,+1

        bind=SUPER,p,togglefloating
        #bind=SUPER,g,toggleglobal

        bind=SUPER,u,viewtoright
        bind=SUPER,i,viewtoleft
        bind=SUPER+Ctrl,u,tagtoright
        bind=SUPER+Ctrl,i,tagtoleft

        bind=SUPER,1,comboview,1
        bind=SUPER,2,comboview,2
        bind=SUPER,3,comboview,3
        bind=SUPER,4,comboview,4
        bind=SUPER,5,comboview,5
        bind=SUPER,6,comboview,6
        bind=SUPER,7,comboview,7
        bind=SUPER,8,comboview,8
        bind=SUPER,9,comboview,9

        bind=SUPER+SHIFT,1,tag,1,0
        bind=SUPER+SHIFT,2,tag,2,0
        bind=SUPER+SHIFT,3,tag,3,0
        bind=SUPER+SHIFT,4,tag,4,0
        bind=SUPER+SHIFT,5,tag,5,0
        bind=SUPER+SHIFT,6,tag,6,0
        bind=SUPER+SHIFT,7,tag,7,0
        bind=SUPER+SHIFT,8,tag,8,0
        bind=SUPER+SHIFT,9,tag,9,0

        bind=SUPER+CTRL,1,toggleview,1,0
        bind=SUPER+CTRL,2,toggleview,2,0
        bind=SUPER+CTRL,3,toggleview,3,0
        bind=SUPER+CTRL,4,toggleview,4,0
        bind=SUPER+CTRL,5,toggleview,5,0
        bind=SUPER+CTRL,6,toggleview,6,0
        bind=SUPER+CTRL,7,toggleview,7,0
        bind=SUPER+CTRL,8,toggleview,8,0
        bind=SUPER+CTRL,9,toggleview,9,0

        # monitor switch
        bind=SUPER,code:60,focusmon,right
        bind=SUPER+shift,code:60,tagmon,right,0

        # Mouse Button Bindings
        # NONE mode key only work in ov mode
        mousebind=SUPER,btn_left,moveresize,curmove
        mousebind=SUPER,btn_right,moveresize,curresize
        mousebind=NONE,btn_left,toggleoverview,-1
        mousebind=NONE,btn_right,killclient,0
      ''
    ];
  };
}
