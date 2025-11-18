{
  flake.modules.nixos.niri = {lib, ...}: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        animations {
        }
      ''
    ];
  };
}
