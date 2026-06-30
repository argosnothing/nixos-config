{
  flake.modules.nixos.budgie = {pkgs, ...}: {
    environment.budgie.excludePackages = with pkgs; [
      mate.mate-terminal
      gnome-terminal
      xterm
      pluma
    ];
    services = {
      xserver = {
        enable = true;
        desktopManager.budgie.enable = true;
        displayManager.lightdm.enable = true;
        excludePackages = with pkgs; [xterm];
      };
    };
  };
}
