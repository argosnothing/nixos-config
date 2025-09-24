''
  # reload config
  bind=SUPER,r,reload_config
  # menu and terminal
  bind=ALT+CTRL+SHIFT,s,spawn,snip
  bind=ALT+CTRL,v,spawn,record-region-start
  bind=ALT+CTRL+SHIFT,v,spawn,record-region-stop
  bind=Alt,space,spawn,rofi -show drun
  bind=Alt,Return,spawn,kitty

  # exit
  bind=SUPER,m,quit
  bind=ALT,c,killclient,

  # switch window focus
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
  bind=ALT,backslash,togglefloating,
  bind=ALT,a,togglemaxmizescreen,
  bind=ALT,f,togglefullscreen,
  bind=ALT+SHIFT,f,togglefakefullscreen,
  bind=SUPER,o,toggleoverlay,
  bind=SUPER+SHIFT,I,restore_minimized

  # scroller layout
  bind=ALT,x,switch_proportion_preset,

  # switch layout
  bind=ALT,n,switch_layout
  bind=ALT+SHIFT,Return,zoom
  bind=ALT,-,incnmaster,-1
  bind=ALT,=,incnmaster,+1


  bind=Alt,1,view,-1,0
  bind=Alt,2,view,-2,0
  bind=Alt,3,view,-3,0
  bind=Alt,4,view,-4,0
  bind=Alt,5,view,-5,0
  bind=Alt,6,view,-6,0
  bind=Alt,7,view,-7,0
  bind=Alt,8,view,-8,0
  bind=Alt,9,view,-9,0

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
  bind=alt+shift,Left,focusmon,left
  bind=alt+shift,Right,focusmon,right

  # Mouse Button Bindings
  # NONE mode key only work in ov mode
  mousebind=ALT,btn_left,moveresize,curmove
  mousebind=ALT,btn_right,moveresize,curresize
  mousebind=NONE,btn_left,toggleoverview,-1
  mousebind=NONE,btn_right,killclient,0
''
