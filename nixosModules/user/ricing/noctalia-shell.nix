{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    noctalia-shell.enable = lib.mkEnableOption "Enable Noctalia Shell Env";
  };

  config = lib.mkIf config.noctalia-shell.enable {
    home.packages =
      [
        inputs.noctalia-shell.packages.${pkgs.system}.default
      ]
      ++ (with pkgs; [
        # Noctalia-specific runtime dependencies
        bash
        brightnessctl
        cava
        cliphist
        coreutils
        ddcutil
        file
        findutils
        gpu-screen-recorder
        libnotify
        matugen
        swww
        wl-clipboard
        wlsunset

        # Fonts required by Noctalia
        roboto
        inter
        material-symbols # Icon font for UI elements
      ]);

    home.sessionVariables = {
      FONTCONFIG_FILE = "${pkgs.makeFontsConf {
        fontDirectories = [
          pkgs.material-symbols
          pkgs.roboto
          pkgs.inter
        ];
      }}";
    };

    custom.persist.home = {
      directories = [".config/noctalia"];
      cache.directories = [".cache/noctalia"];
    };
  };
}
