{
  flake.modules.nixos.firefox = {
    pkgs,
    lib,
    ...
  }: {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.pcscd.enable = true;
    my.persist.home.directories = [
      ".config/mozilla"
      ".local/share/firefoxpwa"
    ];
    my.persist.home.cache.directories = [".cache/mozilla"];
    my.default.associations."text/html" = lib.mkAfter ["firefox.desktop"];
    environment.systemPackages = with pkgs; [
      firefoxpwa
      opensc
      ccid
      pcsc-tools
    ];
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = [pkgs.firefoxpwa];
      preferences = {
        "widget.use-xdg-desktop-portal.open-uri" = 1;
      };
      # Disabled because I use smartcard passthru to vm
      # policies.SecurityDevices = {
      #   "OpenSC PKCS#11" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
      # };
    };
  };
}
