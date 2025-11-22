{config, ...}: let
  inherit (config.flake) packages;
in {
  flake.modules.nvf.default = {pkgs, ...}: let
    inherit (pkgs) vimPlugins;
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    vim = {
      theme = {
        enable = true;
        name = "rose-pine";
        style = "main";
      };
      #extraPlugins = {
      #  ayu = {
      #    package = vimPlugins.neovim-ayu;
      #    setup = ''
      #      require('rose-pine').setup{}
      #      vim.cmd.colorscheme("rose-pine")
      #    '';
      #  };
      #};
      lazy.plugins = {
        # Custom packages I added and overlaid
        "kanso-nvim".package = packages.${system}.kanso-nvim;
        "thorn-nvim".package = packages.${system}.thorn-nvim;
        # Nixpkgs items
        everforest.package = vimPlugins.everforest;
        "lackluster.nvim".package = vimPlugins.lackluster-nvim;
        "kanagawa.nvim".package = vimPlugins.kanagawa-nvim;
        "neovim-ayu".package = vimPlugins.neovim-ayu;
        "catppuccin-nvim".package = vimPlugins.catppuccin-nvim;
        "gruvbox.nvim".package = vimPlugins.gruvbox-nvim;
      };
    };
  };
}
