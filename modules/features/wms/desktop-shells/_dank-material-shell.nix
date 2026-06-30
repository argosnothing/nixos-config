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
    my.desktop-shells = {
      enable = true;
      name = "dms";
      execCommand = "";
      launcherCommand = "dms ipc call spotlight toggle";
    };
  };
}
