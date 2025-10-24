{
  flake.modules.nixos = {
    critical = {
      lib,
      ...
    }: let
      inherit (lib) mkEnableOption;
    in {
      options.my.persist = {
          enable = mkEnableOption "Enable Impermanence";
      };
    };
  };
}
