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
    # Add Nix development tools to home packages
    home.packages = with pkgs; [
      nixd              # Nix LSP server
      alejandra         # Nix formatter (better than nixpkgs-fmt)
      stylua            # Lua formatter
      # statix            # Nix linter (may not be available)
      # shfmt             # Shell script formatter
      # shellcheck        # Shell script linter
    ];
    
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      
      extraLuaConfig = ''
        -- Enable syntax highlighting
        vim.cmd('syntax enable')
        vim.opt.termguicolors = true
        
        -- Basic editor settings
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.cursorline = true
        vim.opt.signcolumn = "yes"
        
        -- Enhanced syntax highlighting settings
        vim.opt.synmaxcol = 3000  -- Increase syntax highlighting limit
        vim.opt.re = 0            -- Use new regex engine
      '';
      
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-tree-lua;
          config = toLuaFile ./nvim-tree.lua;
        }
        nvim-web-devicons
        
        # Enhanced Nix support
        {
          plugin = vim-nix;
          config = toLuaFile ./nix-syntax.lua;
        }
        
        # LSP and completion
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./lsp.lua;
        }
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        luasnip
        cmp_luasnip
        
        # Treesitter for syntax highlighting
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = toLuaFile ./treesitter.lua;
        }
        nvim-treesitter-textobjects
        
        # Formatting and linting
        {
          plugin = none-ls-nvim;
          config = toLuaFile ./none-ls.lua;
        }
      ];
    };
  };
}
