{
  pkgs,
  config,
  settings,
  lib,
  ...
}: {
  options = {
    vscode.enable = lib.mkEnableOption "vscode because you are weak";
  };

  config = lib.mkIf config.vscode.enable {
    home.packages = with pkgs; [alejandra nixd];
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          bbenoist.nix
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          vadimcn.vscode-lldb
          github.copilot
          github.copilot-chat
          yzhang.markdown-all-in-one
        ];
        userSettings = {
          "workbench.iconTheme" = "vs-seti";
          "terminal.integrated.fontLigatures" = true;
          "terminal.integrated.fontFamily" = "MesloLGS NF, FiraCode Nerd Font, JetBrainsMono Nerd Font, monospace";
          "vim.handleKeys" = {
            "<C-a>" = false;
            "<C-f>" = false;
            "<C-p>" = false;
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
          "nixos" = {
            "expr" = "(builtins.getFlake \"${settings.absoluteflakedir}\").nixosConfigurations.${settings.hostname}.options";
          };
          "home-manager" = {
            "expr" = "(builtins.getFlake \"${settings.absoluteflakedir}\").homeConfigurations.\"${settings.username}@${settings.hostname}\".options";
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
  };
}
