{
  pkgs,
  config,
  lib,
  ...
}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
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
      defaultEditor = true;
      
      # Extra packages available to Neovim
      extraPackages = with pkgs; [
        # LSP servers
        nixd
        lua-language-server
        
        # Formatters
        alejandra
        stylua
        
        # Tools
        ripgrep
        fd
        tree-sitter
        git
      ];
      
      plugins = with pkgs.vimPlugins; [
        # File explorer
        {
          plugin = nvim-tree-lua;
          config = toLuaFile ./nvim-tree.lua;
        }
        nvim-web-devicons
        
        # Fuzzy finder
        {
          plugin = telescope-nvim;
          config = toLuaFile ./telescope.lua;
        }
        telescope-fzf-native-nvim
        plenary-nvim
        
        # Navigation
        {
          plugin = harpoon;
          config = toLuaFile ./harpoon.lua;
        }
        
        # Git
        {
          plugin = vim-fugitive;
          config = toLuaFile ./fugitive.lua;
        }
        
        # Utilities
        {
          plugin = undotree;
          config = toLuaFile ./undotree.lua;
        }
        
        # LSP & Completion
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./lsp.lua;
        }
        {
          plugin = nvim-cmp;
          config = toLuaFile ./completion.lua;
        }
        cmp-nvim-lsp
        cmp-buffer
        
        # Syntax highlighting
        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-yaml
            p.tree-sitter-markdown
          ]);
          config = toLuaFile ./treesitter.lua;
        }
        
        # Theme
        gruvbox-nvim
      ];
      
      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';
    };
  };
}
