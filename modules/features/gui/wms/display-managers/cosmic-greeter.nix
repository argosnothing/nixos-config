{
  flake.modules.nixos.cosmic-greeter = {
    services = {
      displayManager.cosmic-greeter = {
        enable = true;
      };
    };
  };
}
