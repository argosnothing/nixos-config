{
  pkgs,
  config,
  lib,
  settings,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative"; # Show relative line numbers
        mouse = false; # Disable mouse support for keyboard-only workflow
        lsp.display-messages = true; # Show LSP diagnostic messages
        file-picker.hidden = false; # Show hidden files in file picker
        auto-save = true; # Auto-save files on focus loss
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
          formatting = {
            command = ["alejandra"];
          };
        };
      };
    };

    # Language server packages and tree-sitter support
    extraPackages = with pkgs; [
      # Language Servers
      gopls # Go language server - provides completion, diagnostics, formatting
      nil # Nix language server - Nix file support with LSP features
      bash-language-server # Bash language server - shell script analysis and completion

      alejandra
      shellcheck #Improves bash highlighting

      # Use 'hx -g fetch' and 'hx -g build' to install/update grammars
    ];
  };
}
