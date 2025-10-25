# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: {
  flake.modules.nixos.base = let
    nixos-modules = with config.flake.modules.nixos; [
      options
      user
      critical
      home
    ];
    home-modules = [
      {
        home-manager.users.${config.flake.settings.username}.imports = with config.flake.modules.homeManager; [
          options
        ];
      }
    ];
    in{
    imports = nixos-modules ++ home-modules;
  };
}
