{
  inputs,
  pkgs,
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
      options.termguicolors = true;
      statusline.lualine.enable = true;
      telescope.enable = true;
      navigation.harpoon.enable = true;
      git.gitsigns.enable = true;
      git.neogit.enable = true;
      autopairs.nvim-autopairs.enable = true;

      # Visual Improvements
      visuals.indent-blankline.enable = true;
      visuals.fidget-nvim.enable = true;

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
      lsp = {
        enable = true;
        trouble.enable = true;
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        nix = {
          enable = true;
          treesitter = {
            enable = true;
          };
          lsp = {
            enable = true;
            server = "nixd";
            options = {
              nixpkgs = {
                expr = "import <nixpkgs> { }";
              };
              formatting = {
                command = ["alejandra"];
              };
              nixos = {
                expr = "(builtins.getFlake \"${settings.absoluteflakedir}\").nixosConfigurations.${settings.hostname}.options";
              };
              home-manager = {
                expr = "(builtins.getFlake \"${settings.absoluteflakedir}\").homeConfigurations.\"${settings.username}@${settings.hostname}\".options";
              };
            };
          };
          extraDiagnostics.enable = true;
          format = {
            enable = true;
            type = "alejandra";
          };
        };
        markdown.enable = true;
      };

      autocomplete = {
        #nvim-cmp.enable = true;
        blink-cmp.enable = true;
      };

      filetree = {
        neo-tree = {
          enable = true;
        };
      };

      tabline = {
        nvimBufferline.enable = true;
      };
      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      notify = {
        nvim-notify.enable = true;
      };

      projects = {
        project-nvim.enable = true;
      };

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        surround.enable = true;
        leetcode-nvim.enable = true;
        multicursors.enable = true;
        smart-splits.enable = true;
        undotree.enable = true;
        nvim-biscuits.enable = true;
        sleuth.enable = true;

        motion = {
          #hop.enable = true;
          #leap.enable = true;
          #precognition.enable = true;
        };
        images = {
          image-nvim.enable = false;
          img-clip.enable = true;
        };
      };
      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };
      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = true;
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            nix = "110";
          };
        };
        fastaction.enable = true;
      };

      comments = {
        comment-nvim.enable = true;
      };
      gestures = {
        gesture-nvim.enable = false;
      };
    };
  };
}
