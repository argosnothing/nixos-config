{
  # This defines nixos options for theming.
  # This is meant to be decoupled from whatever theming solution I happen to be using at the time.
  # Other theming modules like stylix or mutagen/or specific applications i need manual theming on will
  # consume these options
  flake.modules.nixos.options = {lib, ...}: let
    inherit (lib) mkOption types mkEnableOption;
    inherit (types) submodule enum str nullOr;
  in {
    options.my.theme = mkOption {
      default = {};
      type = submodule {
        options = {
          custom = mkOption {
            default = {};
            type = submodule {
              options = {
                enable = mkEnableOption "Enable Custom Theme";
                name = mkOption {
                  type = enum ["occult"];
                  default = "occult";
                };
              };
            };
          };
          polarity = mkOption {
            type = enum ["light" "dark"];
            default = "dark";
          };
          name = mkOption {
            type = str;
          };
          style = mkOption {
            type = nullOr str;
            default = null;
          };
        };
      };
    };
  };
}
