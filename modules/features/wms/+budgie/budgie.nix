{
  flake.modules.nixos.budgie = {pkgs, ...}: {
    my.persist.home.directories = [
      ".config/budgie-desktop"
      ".config/budgie-control-center"
      ".config/gammastep"
      ".local/share/contractor"
    ];
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
