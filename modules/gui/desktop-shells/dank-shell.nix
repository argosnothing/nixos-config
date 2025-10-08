{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.modules.gui.wms) niri;
  is-dank = config.my.modules.gui.desktop-shells.name == "dank-shell";
  dankShell = inputs.dank-shell;
in {
  imports = [
  ];
  config = lib.mkIf is-dank {
    hm = {pkgs, ...}: {
      my.persist.home.directories = [
        ".config/DankMaterialShell"
        ".local/state/DankMaterialShell"
      ];
      imports = [
        dankShell.homeModules.dankMaterialShell.default
        dankShell.homeModules.dankMaterialShell.niri
      ];
      programs.dankMaterialShell = {
        enable = true;
      };
      programs.dankMaterialShell.niri = mkIf niri.enable {
        enableSpawn = true;
      };
      home.packages = [
        dankShell.packages.${pkgs.system}.dankMaterialShell
      ];
    };
    my.modules.gui.desktop-shells = {
      execCommand = "dms run";
      launcherCommand = "dms ipc call spotlight toggle";
      bind = [
      ];
    };
  };
}
