{pkgs, ...}: {
  imports = [
    ./languages.nix
    ./ui.nix
    ./visuals.nix
    ./utility.nix
    ./binds.nix
    ./keymaps.nix
  ];

  vim = {
    vimAlias = true;
    #spellcheck.enable = true;
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

  vim.terminal = {
    toggleterm = {
      enable = true;
    };
  };

  vim.clipboard = {
    registers = "unnamedplus";
    providers = {
      wl-copy = {
        enable = true;
      };
    };
    enable = true;
  };

  vim.treesitter = {
    enable = true;
    context.enable = true;
    fold = true;
  };

  vim = {
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
    };
    runner.run-nvim = {
      enable = true;
    };
  };
}
