{
  flake.modules.nixos.rdp = {pkgs, ...}: {
    services.pcscd.enable = true;
    environment.systemPackages = with pkgs; [
      kdePackages.krdc
      remmina
      opensc
      ccid
    ];
  };
}
