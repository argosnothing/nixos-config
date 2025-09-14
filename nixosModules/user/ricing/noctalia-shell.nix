{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  config = (lib.mkIf config.custom.ricing.shells.shell == "noctalia-shell") {
    custom.ricing.shells.shell = {
      hasShell = true;
      execCommand = "noctalia-shell";
      launcherCommand = "noctalia-shell ipc call launcher toggle";
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
