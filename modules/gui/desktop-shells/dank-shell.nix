{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  dankShell = inputs.dank-shell;
in {
  imports = [
  ];
  config = lib.mkIf (config.my.modules.gui.desktop-shells.name == "dank-shell") {
    hm = {pkgs, ...}: {
      home.packages = [
        dankShell.packages.${pkgs.system}.quickshell
        dankShell.packages.${pkgs.system}.dankMaterialShell
        dankShell.packages.${pkgs.system}.default
      ];
    };
    my.modules.gui.desktop-shells = {
      execCommand = "dms run";
      launcherCommand = "dmps ipc call spotlight toggle";
      bind = [
      ];
    };
  };
}
