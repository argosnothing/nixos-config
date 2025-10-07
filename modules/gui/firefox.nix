{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    my.modules.gui.firefox = {
      enable = lib.mkEnableOption "My firefox";
    };
  };
  config = lib.mkIf config.my.modules.gui.firefox.enable {
    programs.firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.open-uri" = 1;
      };
      policies = {
        SecurityDevices = {
          "OpenSC PKCS#11 Module" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
        };
      };
    };
    hm = _: {
      programs.firefox = {
        enable = true;
        profiles = {
          "default" = {};
          "firefox-scratchpad" = {
            id = 1;
            isDefault = false;
          };
        };
        profiles.default.extensions.force = true;
        profiles.firefox-scratchpad.extensions.force = true;
      };
      stylix.targets.firefox = {
        enable = true;
        profileNames = ["default" "firefox-scratchpad"];
        colorTheme.enable = true;
      };
      my.persist.home = {
        directories = [
          ".mozilla"
        ];
        cache.directories = [
          ".cache/mozzila"
        ];
      };
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
        };
      };
    };
  };
}
