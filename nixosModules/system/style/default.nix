{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [ ../../stylix-config.nix ];
  config = lib.mkIf config.styles.stylix.enable {
    stylix.targets.grub.enable = false;
  };

}