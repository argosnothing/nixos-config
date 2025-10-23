{
  flake.modules.nixos = {
    critical = {
      lib,
      ...
    }: let
      inherit (lib) mkEnableOption;
    in {
      options.impermanence = {
          enable = mkEnableOption "Enable Impermanence";
      };
    };
  };
}
