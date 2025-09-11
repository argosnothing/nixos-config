{
  pkgs,
  inputs,
  settings,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  stylix.targets.nvf.enable = false;
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        vimAlias = true;
        autopairs.nvim-autopairs.enable = true;
        dashboard.alpha = {
          enable = true;
          theme = "theta";
        };
        comments.comment-nvim.enable = true;
        statusline.lualine.enable = true;
        tabline.nvimBufferline.enable = true;
        projects.project-nvim.enable = true;
        telescope.enable = true;
        navigation.harpoon.enable = true;
        theme = {
          enable = true;
          name = "catppuccin";
          style = "frappe";
        };
        extraPackages = [pkgs.vimPlugins.direnv-vim];
      };
    };
  };

  programs.nvf.settings.vim.ui = {
    borders.enable = true;
    colorizer.enable = true;
    illuminate.enable = true;
    fastaction.enable = true;
    smartcolumn = {
      enable = true;
      setupOpts.custom_colorcolumn = {
        nix = "110";
        go = ["90" "130"];
        python = ["80" "120"];
      };
    };

    noice.enable = true;
    breadcrumbs = {
      enable = true;
      lualine.winbar.enable = true;
      navbuddy.enable = true;
    };
  };

  programs.nvf.settings.vim.visuals = {
    nvim-scrollbar.enable = true;
    nvim-web-devicons.enable = true;
    nvim-cursorline.enable = true;

    cinnamon-nvim.enable = true;
    fidget-nvim.enable = true;
    highlight-undo.enable = true;
    indent-blankline.enable = true;
    rainbow-delimiters.enable = true;
  };

  #LSP Direct Configs
  programs.nvf.settings.vim.lsp = {
    enable = true;
  };

  programs.nvf.settings.vim.languages = {
    enableTreesitter = true;
  };

  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    format = {
      enable = true;
      type = "alejandra";
    };
    lsp = {
      server = "nixd";
      enable = true;
      options = {
      };
    };
  };

  programs.nvf.settings.vim.languages.rust = {
    enable = true;
    crates.enable = true;
  };

  programs.nvf.settings.vim.utility = {
    direnv.enable = true;
    mkdir.enable = true;
    nix-develop.enable = true;
    oil-nvim.enable = true;
    sleuth.enable = true;
  };

  programs.nvf.settings.vim.terminal = {
    toggleterm = {
      enable = true;
    };
  };

  programs.nvf.settings.vim.clipboard = {
    enable = true;
  };

  programs.nvf.settings.vim.binds = {
    whichKey.enable = true;
    cheatsheet.enable = true;
  };

  programs.nvf.settings.vim.treesitter = {
    enable = true;
    context.enable = true;
    fold = true;
  };

  programs.nvf.settings.vim = {
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
    };
    runner.run-nvim = {
      enable = true;
    };
  };
}
