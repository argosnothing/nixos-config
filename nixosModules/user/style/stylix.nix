{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
    ../../user/scripts/export-colors.nix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      enable = true;
      profileNames = [ "default" ];
    };
  };
}
