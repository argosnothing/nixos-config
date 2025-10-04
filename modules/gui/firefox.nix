{
  pkgs,
  settings,
  lib,
  config,
  ...
}: let
  browserMimes = [
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "text/html"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/xhtml+xml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
  ];

  createBrowserList = browsers:
    lib.listToAttrs (map (mimeType: {
        name = mimeType;
        value = browsers;
      })
      browserMimes);
in {
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
    environment = {
      sessionVariables = {
        DEFAULT_BROWSER = lib.getExe pkgs.firefox;
        BROWSER = lib.getExe pkgs.firefox;
      };
    };
    xdg.mime = {
      enable = true;
      defaultApplications = createBrowserList ["firefox.desktop"];
      addedAssociations = createBrowserList [
        "firefox.desktop"
      ];
    };
  };
}
