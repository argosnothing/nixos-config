{inputs, ...}: {
  flake.modules.nixos.dms = {
    imports = [
    ];
    my.desktop-shells = {
      name = "dms";
      execCommand = "dms run";
      launcherCommand = "dms ipc call spotlight toggle";
    };
    hm = {
      imports = [
        inputs.dms.homeModules.dankMaterialShell.default
      ];
      programs.dankMaterialShell = {
        enable = true;
        enableSystemd = true;
      };
    };
  };
}
