{lib, ...}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) str;
in {
  options.flake.settings = {
    username = mkOption {
      description = "It's me!";
      type = str;
      default = "salivala";
    };
    persist.enable = mkEnableOption "Enable Impermanence";
    networking.hostId = mkOption {
      description = "Host Id";
      type = str;
      default = "AB12CD34";
    };
    isVm = lib.mkEnableOption "Is the host a VM";
  };
  config = {
    flake.modules.nixos.lazy = {
      options.lazy.beans = lib.mkEnableOption "ok";
    };
  };
}
