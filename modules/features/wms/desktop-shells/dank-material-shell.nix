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
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting from the clipboard history (wtype)      quickshell.package = inputs.quickshell.packages.${pkgs.system}.quickshell;
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
