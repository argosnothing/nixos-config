{
  pkgs,
  config,
  lib,
  settings,
  inputs,
  ...
}: {
  options = {
    helix.enable = lib.mkEnableOption "feeling adventurous are we?";
  };
  config = lib.mkIf config.helix.enable {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          mouse = false;
          lsp.display-messages = true;
          file-picker.hidden = false;
          auto-save = true;
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

      extraPackages = with pkgs; [
        gopls
        nil
        bash-language-server
        alejandra
        shellcheck
      ];
    };
  };
}
