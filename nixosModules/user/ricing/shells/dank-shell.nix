{
  pkgs,
  inputs,
  lib,
  settings,
  config,
  ...
}: {
  imports = [inputs.dank-shell.homeModules.dankMaterialShell];
  config = lib.mkIf (config.custom.desktop-shell.name == "dank-shell") {
    custom.desktop-shell = {
      execCommand = "dms run";
      launcherCommand = "dmps ipc call spotlight toggle";
      bind = [
      ];
    };
    programs.dankMaterialShell = {
      enable = true;
    };
  };
}
