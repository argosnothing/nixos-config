{
  flake.modules.nixos.discord = {
    hm = {
      stylix.targets.vesktop.enable = false;
      programs = {
        vesktop = {
          enable = true;
          settings = {
            hardwareAcceleration = false;
          };
        };
      };
      my.persist.home.directories = [
        ".config/discord"
        ".config/vencord"
        ".config/vesktop"
      ];
    };
  };
}
