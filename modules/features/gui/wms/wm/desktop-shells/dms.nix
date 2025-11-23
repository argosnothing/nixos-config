{inputs, ...}: {
  flake.modules.nixos.dms = {
    my = {
      persist = {
        home.cache.directories = [
          ".cache/DankMaterialShell"
        ];
        home.directories = [
          ".config/DankMaterialShell"
          ".local/state/DankMaterialShell"
        ];
      };
      desktop-shells = {
        name = "dms";
        execCommand = "dms run";
        launcherCommand = "dms ipc call spotlight toggle";
      };
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
