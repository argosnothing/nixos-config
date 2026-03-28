{inputs, ...}: {
  flake.modules.nixos.dank-material-shell = {
    pkgs,
    config,
    ...
  }: {
    programs.dms-shell = {
      enable = true;
      quickshell.package = inputs.quickshell.packages.${pkgs.system}.quickshell;
    };
    my.persist.home.directories = [
      ".config/DankMaterialShell"
      ".local/share/state/DankMaterialShell"
      ".local/share/color-schemes"
      ".local/state/DankMaterialShell"
      ".config/dgop"
    ];
    my.persist.home.cache.directories = [
      ".cache/DankMaterialShell"
      ".cache/wal"
      ".cache/quickshell"
    ];
    my.desktop-shells = {
      enable = true;
      name = "dms";
      execCommand = "dms run";
      launcherCommand = "dms ipc call spotlight toggle";
    };
  };
}
