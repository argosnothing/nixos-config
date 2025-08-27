{
  inputs,
  lib,
  settings,
  ...
}: {
  stylix.targets.nvf.enable = false;
  imports = [inputs.nvf.homeManagerModules.default];
  programs.nvf = {
    enable = true;
    settings.vim = {
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };
      # Enable true color support
      options.termguicolors = true;
      utility.sleuth.enable = true;
      binds.whichKey.enable = true;
      ui.noice.enable = true;
      ui.colorizer.enable = true;
      statusline.lualine.enable = true;
      telescope = {
        enable = true;
        setupOpts = {
          defaults.color_devicons = true;
          defaults.file_ignore_patterns = ["%.git/"];
        };
      };
      autocomplete.nvim-cmp = {
        enable = true;
        setupOpts.sources = lib.mkForce [
          {name = "nvim_lsp"; priority = 1000;}
          {name = "path"; priority = 250;}
          {name = "buffer"; keyword_length = 3; priority = 50;}
        ];
      };

      # File Management
      filetree.nvimTree = {
        enable = true;
        setupOpts.renderer.icons.webdev_colors = true;
      };
      navigation.harpoon.enable = true;

      # Buffer & Window Management
      utility.smart-splits.enable = true;
      tabline.nvimBufferline.enable = true;

      # Git Integration
      git.gitsigns.enable = true;
      git.neogit.enable = true;

      # Code Enhancement
      autopairs.nvim-autopairs.enable = true;
      comments.comment-nvim.enable = true;
      utility.surround.enable = true;

      # Visual Improvements
      ui.illuminate.enable = true;
      visuals.indent-blankline.enable = true;
      visuals.fidget-nvim.enable = true;

      # Terminal & Motion
      terminal.toggleterm.enable = true;
      utility.motion.flash-nvim.enable = true;
      debugger.nvim-dap.enable = true;

      # Code Analysis & Navigation
      lsp.trouble.enable = true;

      ui.breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };

      # AI Assistant & Visual Enhancements
      assistant = {
        copilot.enable = true;
        codecompanion-nvim.enable = true;
      };
      visuals.nvim-web-devicons = {
        enable = true;
        setupOpts = {
          color_icons = true;
          default = true;
        };
      };

      languages = {
        enableTreesitter = true;
        enableFormat = true;
        nix = {
          enable = true;
          treesitter.enable = true;
          lsp = {
            enable = true;
            server = "nixd";
            # Configure nixd options through the language module - this is the proper nvf way
            options = {
              nixpkgs = {
                expr = "import <nixpkgs> { }";
              };
              options = {
                nixos = {
                  expr = "(builtins.getFlake \"/home/salivala/nixos-config\").nixosConfigurations.${settings.hostname}.options";
                };
                home_manager = {
                  expr = "(builtins.getFlake \"/home/salivala/nixos-config\").homeConfigurations.\"${settings.username}@${settings.hostname}\".options";
                };
              };
              formatting = {
                command = ["alejandra"];
              };
            };
          };
          format.enable = true;  # Enable formatting through the module
        };
        ts = {
          enable = true;
          format.enable = false; # Disable TS formatting for now
        };
        rust.enable = true;
      };

      lsp = {
        enable = true;
        # Remove nixd from servers - it's handled by the language module now
      };
    };
  };
}
