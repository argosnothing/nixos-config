{
  flake.modules.nixos.niri = {lib, ...}: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        recent-windows {
          Mod+Tab         { next-window; }
          Mod+Shift+Tab   { previous-window; }
          Mod+grave       { next-window     filter="app-id"; }
          Mod+Shift+grave { previous-window filter="app-id"; }
        }
      ''
    ];
  };
}
