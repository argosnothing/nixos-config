{
  pkgs,
  config,
  lib,
  ...
}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
in
{
  options = {
    neovim.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Neovim text editor with custom configuration.";
    };
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = example;
          config = toLua "wow!"
        }

        (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]))
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./neovim/options.lua}
      '';
    };
  };
}
