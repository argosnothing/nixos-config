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
  };
}
