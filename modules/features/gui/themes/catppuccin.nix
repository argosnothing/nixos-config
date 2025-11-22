{
  flake.modules.nixos.catppuccin = {
    pkgs,
    config,
    ...
  }: let
    inherit (config.my.theme) polarity;
    is-dark = polarity == "dark";
    theme-name =
      if is-dark
      then "catppuccin"
      else "catppuccin-latte";
  in {
    my = {
      theme = {
        accent = "#c4a7e7";
        name = theme-name;
      };
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
    };

    hm = {
      pkgs,
      lib,
      config,
      ...
    }: let
      inherit (lib) mkForce;
    in
      lib.mkMerge [
        {
          gtk = {
            gtk2 = {
              enable = true;
              theme.name = mkForce theme-name;
              theme.package = mkForce pkgs.catppuccin-gtk;
            };
            enable = true;
            theme.name = mkForce theme-name;
            theme.package = mkForce pkgs.catppuccin-gtk;
          };
        }
        (lib.mkIf (config.programs.vesktop.enable or false) (let
          theme-base = "auto-theme";
          css-file = "${theme-base}.css";
          theme-type =
            if polarity == "dark"
            then "latte"
            else "frappe";
        in {
          home.file.".config/vesktop/themes/${css-file}".source = "${pkgs.catppuccin-discord}/themes/${theme-type}.theme.css";
        }))
      ];
  };
}
