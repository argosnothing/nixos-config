{config, ...}: {
  flake.modules.nixos.sddm = {
    imports = [config.flake.modules.nixos.display-manager];
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };
  };
}
