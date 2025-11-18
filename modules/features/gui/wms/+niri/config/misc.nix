{
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    ...
  }: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        xwayland-satellite {
          path "${lib.getExe pkgs.xwayland-satellite-unstable}"
        }

        prefer-no-csd
      ''
    ];
  };
}
