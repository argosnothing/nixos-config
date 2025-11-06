{
  flake.modules.nixos.rose-pine = {
    pkgs,
    config,
    ...
  }: let
    inherit (config.my.theme) polarity;
    is-dark = polarity == "dark";
  in {
    my = {
      theme = {
        name =
          if is-dark
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
        theme.name =
          if is-dark
          then mkForce "rose-pine"
          else mkForce "rose-pine-dawn";
        theme.package = mkForce pkgs.rose-pine-gtk-theme;
      };
    };
  };
}
