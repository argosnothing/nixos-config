{
  flake.modules.nixos.starship = {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        line_break = {
          disabled = false;
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
