{
  flake.modules.nixos.firefox = {pkgs, ...}: {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    my.persist.home.directories = [
      ".mozilla"
      ".local/share/firefoxpwa"
    ];
    my.persist.home.cache.directories = [".cache/mozilla"];
    environment.systemPackages = with pkgs; [
      firefoxpwa
    ];
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = [pkgs.firefoxpwa];
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
