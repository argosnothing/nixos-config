{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
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
  };
}
