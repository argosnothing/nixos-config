{
  lib,
  config,
  ...
}: {
  options.my.modules.shell.starship = {
    enable = lib.mkEnableOption "Starship is fun!";
  };
  config = lib.mkIf config.my.modules.shell.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        line_break = {
          disabled = true;
        };
        character = {
          success_symbol = "[λ](bold green) ";
          error_symbol = "[λ](bold red) ";
        };
        directory = {
          truncation_length = 3;
          truncate_to_repo = false;
          truncation_symbol = ".../";
        };
      };
    };
  };
}
