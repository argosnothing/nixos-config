{
  flake.modules.nixos.firefox = {pkgs, ...}: {
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
    hm = {
      stylix.targets.firefox.enable = false;
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
      my.persist.home = {
        directories = [
          ".mozilla"
        ];
        cache.directories = [
          ".cache/mozilla"
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
