{
  flake.modules.nixos.mango = {lib, ...}: {
    my.wm.mango.settings =
      lib.mkAfter [
      ];
  };
}
