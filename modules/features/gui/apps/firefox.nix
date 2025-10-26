{
  flake.modules.nixos.firefox = {
    pkgs,
    lib,
    options,
    ...
  }: {
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
    hm =
      {
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
      }
      // lib.optionalAttrs (builtins.hasAttr "stylix" options) {
        stylix.targets.firefox = {
          enable = true;
          profileNames = ["default" "firefox-scratchpad"];
          colorTheme.enable = true;
        };
      };
  };
}
