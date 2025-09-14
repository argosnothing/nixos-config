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
    ricing = {
      hasShell = true;
      execCommand = "noctalia-shell";
    };
    home.packages =
      [
        inputs.noctalia-shell.packages.${pkgs.system}.default
        inputs.quickshell.packages.${pkgs.system}.default
      ]
      ++ (with pkgs; [
        kdePackages.qt5compat
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
        roboto
        inter
        material-symbols
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
