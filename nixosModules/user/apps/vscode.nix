{pkgs, ...}:
{
  home.packages = with pkgs; [ alejandra nixd ];
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        github.copilot
        github.copilot-chat
        yzhang.markdown-all-in-one
        mkhl.direnv
      ];
      userSettings = {
        "workbench.iconTheme" = "vs-seti";
        "terminal.integrated.fontLigatures" = true;
        "terminal.integrated.fontFamily" = "MesloLGS NF, FiraCode Nerd Font, JetBrainsMono Nerd Font, monospace";
        
        # Fix Vim key repeat
        "vim.handleKeys" = {
          "<C-a>" = false;
          "<C-f>" = false;
        };
        "vim.useSystemClipboard" = true;
        "vim.useCtrlKeys" = true;
        "vim.hlsearch" = true;
        "vim.insertModeKeyBindings" = [];
        "vim.normalModeKeyBindingsNonRecursive" = [];
        "vim.autoindent" = true;
        
        # Enable key repeat for all keys in VS Code
        "keyboard.dispatch" = "keyCode";
        
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nixpkgs" = {
          "expr" = "import <nixpkgs>";
        };
        "nix.formatterPath" = "alejandra";
        "formatting" = {
          "command" = ["alejandra"];
        };
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
          };
        };
      };
    };
  };
}
