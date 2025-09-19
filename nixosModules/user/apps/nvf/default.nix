{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./languages.nix
    ./ui.nix
    ./visuals.nix
    ./utility.nix
    ./binds.nix
  ];

  config = {
    stylix.targets.nvf.enable = false;
    custom = {
      persist = {
        home = {
          cache.directories = [
            ".cache/nvf"
          ];
          directories = [
            ".local/share/nvf"
          ];
        };
      };
    };
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
            style = "mocha";
          };
          extraPackages = [pkgs.vimPlugins.direnv-vim];
        };
      };
    };

    programs.nvf.settings.vim.terminal = {
      toggleterm = {
        enable = true;
      };
    };

    programs.nvf.settings.vim.clipboard = {
      enable = true;
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
  };
}
