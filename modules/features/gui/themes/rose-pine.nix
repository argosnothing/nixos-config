{
  flake.modules.nixos.rose-pine = {
    pkgs,
    config,
    ...
  }: let
    inherit (config.my.theme) polarity;
  in {
    my = {
      theme = {
        name =
          if polarity == "dark"
          then "rose-pine"
          else "rose-pine-dawn";
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
