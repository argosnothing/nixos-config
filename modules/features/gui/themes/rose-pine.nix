{inputs, ...}: {
  flake.modules.nixos.rose-pine = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (config.my.theme) polarity;
    is-dark = polarity == "dark";
    theme-name =
      if is-dark
      then "rose-pine"
      else "rose-pine-dawn";
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
              theme.package = mkForce pkgs.rose-pine-gtk-theme;
            };
            enable = true;
            theme.name = mkForce theme-name;
            theme.package = mkForce pkgs.rose-pine-gtk-theme;
          };
        }
        (lib.mkIf (config.programs.vesktop.enable or false) (let
          rose-pine-discord = pkgs.fetchFromGitHub {
            owner = "rose-pine";
            repo = "discord";
            rev = "main";
            hash = "sha256-UmjpfodGv8MU+QHIh8L9cQ0JrPfYpBZrjWpkjnx40HY=";
          };
          theme-base = theme-name;
          css-file = "${theme-base}.css";
        in {
          home.file.".config/vesktop/themes/auto-theme.css".source = "${rose-pine-discord}/dist/${css-file}";
        }))
      ];
  };
}
