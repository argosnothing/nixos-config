{
  pkgs,
  config,
  lib,
  ...
}: {
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
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      
      # Extra packages available to Neovim
      extraPackages = with pkgs; [
        # LSP servers
        nixd
        lua-language-server
        
        # Formatters
        alejandra # Nix formatter
        stylua # Lua formatter
        
        # Tools
        ripgrep
        fd
        tree-sitter
        git
      ];

      # Basic Neovim configuration
      extraLuaConfig = ''
        -- Basic settings
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.expandtab = true
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.smartindent = true
        vim.opt.wrap = false
        vim.opt.hlsearch = false
        vim.opt.incsearch = true
        vim.opt.scrolloff = 8
        vim.opt.signcolumn = "yes"
        vim.opt.updatetime = 50
        vim.opt.colorcolumn = "80"

        -- Leader key
        vim.g.mapleader = " "

        -- Basic keybinds
        vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
        vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
        vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
        vim.keymap.set("n", "<C-d>", "<C-d>zz")
        vim.keymap.set("n", "<C-u>", "<C-u>zz")
        vim.keymap.set("n", "n", "nzzzv")
        vim.keymap.set("n", "N", "Nzzzv")
        
        -- Copy to system clipboard
        vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
        vim.keymap.set("n", "<leader>Y", [["+Y]])
      '';

      plugins = with pkgs.vimPlugins; [
        # Essential plugins
        {
          plugin = telescope-nvim;
          type = "lua";
          config = ''
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
              builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end)
          '';
        }
        
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = ''
            require'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true,
              },
              indent = {
                enable = true,
              },
            }
          '';
        }

        {
          plugin = harpoon;
          type = "lua";
          config = ''
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            
            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
            
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
          '';
        }

        {
          plugin = undotree;
          type = "lua";
          config = ''
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
          '';
        }

        {
          plugin = vim-fugitive;
          type = "lua";
          config = ''
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
          '';
        }

        # LSP configuration
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = ''
            local lsp = require('lspconfig')
            
            -- Nix LSP
            lsp.nixd.setup({
              cmd = { "nixd" },
              settings = {
                nixd = {
                  formatting = {
                    command = { "alejandra" }
                  }
                }
              }
            })
            
            -- Lua LSP
            lsp.lua_ls.setup({
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                  },
                  diagnostics = {
                    globals = {'vim'},
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })

            -- LSP keybinds
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>f', function()
                  vim.lsp.buf.format { async = true }
                end, opts)
              end,
            })
          '';
        }

        # Completion
        {
          plugin = nvim-cmp;
          type = "lua";
          config = ''
            local cmp = require'cmp'
            
            cmp.setup({
              mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
              })
            })
          '';
        }

        # Dependencies for completion and telescope
        cmp-nvim-lsp
        cmp-buffer
        telescope-fzf-native-nvim
        plenary-nvim
        
        # Color scheme
        {
          plugin = gruvbox-nvim;
          type = "lua";
          config = ''
            vim.cmd.colorscheme("gruvbox")
          '';
        }
      ];
    };
  };
}
