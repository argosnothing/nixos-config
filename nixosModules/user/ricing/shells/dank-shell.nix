{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  dankShell = inputs.dank-shell;
in {
  config = lib.mkIf (config.custom.desktop-shell.name == "dank-shell") {
    home.packages = [
      dankShell.packages.${pkgs.system}.quickshell
      dankShell.packages.${pkgs.system}.dankMaterialShell
      dankShell.packages.${pkgs.system}.default
    ];
    custom.desktop-shell = {
      execCommand = "dms run";
      launcherCommand = "dmps ipc call spotlight toggle";
      bind = [
      ];
    };
  };
}
