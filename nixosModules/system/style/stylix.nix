{
  inputs,
  pkgs,
  settings,
  ...
}: {
  imports = [ ../../stylix-config.nix ];
  stylix.targets.grub.enable = false;
}
