{
  flake.modules.nvf.default = {
    vim.ui = {
      borders.enable = true;
      colorizer = {
        enable = true;
        setupOpts = {
          filetypes = {
            "*" = {
              AARRGGBB = true;
              RGB = true;
              RRGGBB = true;
              RRGGBBAA = true;
            };
          };
        };
      };
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
  };
}
