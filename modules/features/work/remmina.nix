{
  flake.modules.nixos.remmina = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      freerdp
      remmina
      opensc
      pcsclite
      p11-kit
    ];
  };
}
