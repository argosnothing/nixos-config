{
  flake.modules.nixos.disabled = {
    pkgs,
    lib,
    ...
  }: {
    hm.programs.niri.settings = {
      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite-unstable;
      };
      prefer-no-csd = true;
    };
  };
}
