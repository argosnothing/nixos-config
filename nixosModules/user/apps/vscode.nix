{
  pkgs,
  pkgsUnstable,
  ...
}: {
  home.packages = with pkgs; [alejandra nixd ];
  programs.vscode = {
    enable = true;
    package = pkgsUnstable.vscode;
    profiles.default = {
      extensions = with pkgsUnstable.vscode-extensions; [
        vscodevim.vim
        bbenoist.nix
        jnoortheen.nix-ide
        github.copilot
        github.copilot-chat
        yzhang.markdown-all-in-one
      ];
      userSettings = {
        "workbench.iconTheme" = "vs-seti";
        "workbench.colorTheme" = "Github Light";
        "terminal.integrated.fontLigatures" = true;
        "terminal.integrated.fontFamily" = "MesloLGS NF, FiraCode Nerd Font, JetBrainsMono Nerd Font, monospace";
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
        "qt-qml.qmlls.useQmlImportPathEnvVar" = true;

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
