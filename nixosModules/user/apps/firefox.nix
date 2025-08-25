{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "User Firefox browser.";
    };
  };
  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      policies = {
        SecurityDevices = {
          "OpenSC PKCS#11 Module" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };

    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    };
  };
}
