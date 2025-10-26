{
  flake.modules.nixos.discord = {
    options,
    lib,
    ...
  }: {
    hm =
      {
        programs = {
          vesktop = {
            enable = true;
            settings = {
              hardwareAcceleration = true;
            };
          };
        };
        my.persist.home.directories = [
          ".config/discord"
          ".config/vencord"
          ".config/vesktop"
        ];
      }
      // lib.optionalAttrs (builtins.hasAttr "stylix" options) {
        stylix.targets.vesktop.enable = false;
      };
  };
}
