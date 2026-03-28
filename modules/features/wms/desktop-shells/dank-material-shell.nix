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
    ];
    my.desktop-shells = {
      enable = true;
      name = "dms";
      execCommand = "dms run";
      launcherCommand = "dms ipc call spotlight toggle";
    };
  };
}
