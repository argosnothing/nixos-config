{
  pkgs,
  settings,
  lib,
  config,
  ...
}: let
  ## CREDIT: https://github.com/Michael-C-Buckley/nixos/blob/e7408829a38a5ab6edea4d20785782e45ac44f63/flake/nixos/modules/system/mime.nix#L26
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
    hj.files = {
      ".local/share/applications/firefox.desktop".text = ''
        [Desktop Entry]
        Name=Firefox (URL)
        Type=Application
        Exec=firefox %u
        Terminal=false
        Categories=Network;WebBrowser;
        MimeType=x-scheme-handler/http;x-scheme-handler/https;
        NoDisplay=false
      '';
      ".config/mimeapps.list".text = ''
        [Default Applications]
        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
      '';
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
