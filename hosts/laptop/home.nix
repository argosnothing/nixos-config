{pkgs, ...}: {
  imports = [
    ../home.nix # Import shared home configuration
  ];

  services.libinput = {
    enable = true;
    touchpad = {
      accelSpeed = "0.5";
      accelProfile = "adaptive";
    };
  };
  # Add laptop-specific packages to the shared list
  home.packages = with pkgs; [
    loupe
  ];
}
