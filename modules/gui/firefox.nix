{
  pkgs,
  settings,
  lib,
  config,
  ...
}: {
  options = {
    my.modules.gui.firefox = {
      enable = lib.mkEnableOption "My firefox";
    };
  };
  config = lib.mkIf config.my.modules.gui.firefox.enable {
    hjem.users.${settings.username} = {
    };
    programs.firefox = {
      enable = true;
      policies = {
        SecurityDevices = {
          "OpenSC PKCS#11 Module" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
        };
      };
    };
    xdg.mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
}
