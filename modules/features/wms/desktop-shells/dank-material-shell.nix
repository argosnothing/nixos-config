{inputs, ...}: {
  flake.modules.nixos.dank-material-shell = {
    pkgs,
    config,
    ...
  }: {
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
      };

      # Core features
      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
      enableClipboardPaste = true;
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
      execCommand = "";
      launcherCommand = "dms ipc call spotlight toggle";
    };
  };
}
