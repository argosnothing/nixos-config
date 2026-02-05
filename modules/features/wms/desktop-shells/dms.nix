{inputs, ...}: {
  flake.modules.nixos.dms = {pkgs, ...}: {
    programs.dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
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
  };
}
