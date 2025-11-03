{
  flake.modules.nixos.rose-pine = {pkgs, ...}: {
    my = {
      theme = {
        name = "rose-pine";
      };
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
    };

    hm = {
      pkgs,
      lib,
      ...
    }: let
      inherit (lib) mkForce;
    in {
      gtk = {
        enable = true;
        theme.name = mkForce "rose-pine";
        theme.package = mkForce pkgs.rose-pine-gtk-theme;
      };
    };
  };
}
