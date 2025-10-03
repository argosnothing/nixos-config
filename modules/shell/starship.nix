{
  pkgs,
  lib,
  config,
  settings,
  inputs,
  ...
}: let
  inherit (inputs.std.lib.serde) toTOML;
in {
  options.my.modules.shell.starship = {
    enable = lib.mkEnableOption "Starship is fun!";
  };
  config = lib.mkIf config.my.modules.shell.starship.enable {
    programs.starship = {
      enable = true;
    };
    hjem.users.${settings.username} = {
      files = {
        ".config/starship.toml" = {
          generator = toTOML;
          value = {
            "$schema" = "https://starship.rs/config-schema.json";
            "add_newline" = false;
            format = ''$directory$character$nix_shell$direnv$env_var$cmd_duration$battery'';
            right_format = "$git_branch";
            character = {
              format = "$symbol ";
            };
            os = {
              disabled = false;
            };
            os.symbols = {
            };
            line_break = {
              disabled = true;
            };
          };
        };
      };
    };
  };
}
