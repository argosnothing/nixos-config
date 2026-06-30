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
      opensc
      ccid
      pcsc-tools
    ];
    programs.firefox = {
      enable = true;
      # Disabled because I use smartcard passthru to vm
      # policies.SecurityDevices = {
      #   "OpenSC PKCS#11" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
      # };
    };
  };
}
