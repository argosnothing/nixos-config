{
  flake.modules.nixos."themes/oxocarbon" = {
    my = {
      theme = {
        name = "oxocarbon";
      };
      cursor = {
      };
    };
    hm = {lib, ...}: let
      inherit (lib) mkForce;
    in {
      stylix.targets = {
        discord.enable = true;
        firefox = {
          enable = true;
          profileNames = ["default"];
          colorTheme.enable = true;
        };
      };
    };
  };
}
