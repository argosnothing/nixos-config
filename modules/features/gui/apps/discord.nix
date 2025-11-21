{
  flake.modules.nixos.discord = {lib, ...}: {
    hm = {
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
