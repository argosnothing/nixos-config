{
  flake.modules.nixos.mango = {
    lib,
    config,
    ...
  }: {
    my.wm.mango.settings = lib.mkAfter [
      ''
        # reload config
        bind=ALT+SHIFT,r,reload_config
        # menu and terminal
        bind=ALT+CTRL+SHIFT,s,spawn,snip
        #bind=ALT+CTRL,v,spawn,record-region-start
        #bind=ALT+CTRL+SHIFT,v,spawn,record-region-stop
        bind=ALT,space,spawn,${config.my.desktop-shells.launcherCommand}
        bind=ALT,Return,spawn,kitty

        # exit
        bind=ALT,q,killclient,

        # switch window focus
        bind=ALT,Left,focusdir,left
        bind=ALT,Right,focusdir,right
        bind=ALT,Up,focusdir,up
        bind=ALT,Down,focusdir,down

        bind=ALT,h,focusdir,left
        bind=ALT,l,focusdir,right
        bind=ALT,k,focusdir,up
        bind=ALT,j,focusdir,down

        # swap window
        # bind=ALT+SHIFT,j,exchange_stack_client,next
        # bind=ALT+SHIFT,k,exchange_stack_client,prev
        bind=ALT+CTRL,k,exchange_client,up
        bind=ALT+CTRL,j,exchange_client,down
        bind=ALT+CTRL,h,exchange_client,left
        bind=ALT+CTRL,l,exchange_client,right

        # switch window status
        bind=ALT,backslash,togglefloating,
        bind=ALT,f,togglefullscreen,
        #bind=Alt,f,set_proportion,1.0
        bind=ALT,o,toggleoverlay,

        # scroller layout
        bind=ALT,r,switch_proportion_preset,

        # switch layout
        bind=ALT+SHIFT,Return,zoom
        bind=ALT,code:20,incnmaster,-1
        bind=ALT,code:21,incnmaster,+1

        bind=ALT,p,togglefloating
        bind=ALT,g,toggleglobal

        bind=Alt,u,viewtoright
        bind=Alt,i,viewtoleft

        bind=ALT,1,comboview,1
        bind=ALT,2,comboview,2
        bind=ALT,3,comboview,3
        bind=ALT,4,comboview,4
        bind=ALT,5,comboview,5
        bind=ALT,6,comboview,6
        bind=ALT,7,comboview,7
        bind=ALT,8,comboview,8
        bind=ALT,9,comboview,9

        bind=ALT+SHIFT,1,tag,1,0
        bind=ALT+SHIFT,2,tag,2,0
        bind=ALT+SHIFT,3,tag,3,0
        bind=ALT+SHIFT,4,tag,4,0
        bind=ALT+SHIFT,5,tag,5,0
        bind=ALT+SHIFT,6,tag,6,0
        bind=ALT+SHIFT,7,tag,7,0
        bind=ALT+SHIFT,8,tag,8,0
        bind=ALT+SHIFT,9,tag,9,0

        bind=ALT+CTRL,1,toggleview,1,0
        bind=ALT+CTRL,2,toggleview,2,0
        bind=ALT+CTRL,3,toggleview,3,0
        bind=ALT+CTRL,4,toggleview,4,0
        bind=ALT+CTRL,5,toggleview,5,0
        bind=ALT+CTRL,6,toggleview,6,0
        bind=ALT+CTRL,7,toggleview,7,0
        bind=ALT+CTRL,8,toggleview,8,0
        bind=ALT+CTRL,9,toggleview,9,0

        # monitor switch
        bind=ALT,code:60,focusmon,right
        bind=ALT+shift,code:60,tagmon,right,0

        # Mouse Button Bindings
        # NONE mode key only work in ov mode
        mousebind=ALT,btn_left,moveresize,curmove
        mousebind=ALT,btn_right,moveresize,curresize
        mousebind=NONE,btn_left,toggleoverview,-1
        mousebind=NONE,btn_right,killclient,0
      ''
    ];
  };
}
