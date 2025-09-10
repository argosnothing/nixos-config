{pkgs, config, lib, ...}: {

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
        gopls = {
          command = "gopls"; #
        };
        nil = {
          command = "nil";
        };
        bash-language-server = {
          command = "bash-language-server"; #
          args = ["start"];
        };
      };
      language = [
        {
          name = "go";
          language-servers = ["gopls"];
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = ["nil"];
          auto-format = true;
        }
        {
          name = "bash";
          language-servers = ["bash-language-server"];
          auto-format = false;
        }
      ];
    };

    # Language server packages and tree-sitter support
    extraPackages = with pkgs; [
      # Language Servers
      gopls # Go language server - provides completion, diagnostics, formatting
      nil # Nix language server - Nix file support with LSP features
      bash-language-server # Bash language server - shell script analysis and completion

      # Formatters (for better syntax highlighting and formatting)
      alejandra
      shellcheck #Improves bash highlighting

      # Use 'hx -g fetch' and 'hx -g build' to install/update grammars
    ];
  };
}
