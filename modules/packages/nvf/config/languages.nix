{
  flake.modules.nvf.default = {
    vim = {
      #LSP Direct Configs
      lsp = {
        enable = true;
      };
      languages = {
        enableTreesitter = true;
        enableFormat = true;

        nix = {
          enable = true;
          extraDiagnostics.enable = true;
          format = {
            enable = true;
            type = ["alejandra"];
          };
          lsp = {
            servers = ["nil"];
            enable = true;
          };
        };

        markdown = {
          enable = true;
          extensions.markview-nvim.enable = true;
        };

        clang = {
          enable = true;
          dap = {
            enable = true;
          };
        };

        rust = {
          enable = true;
          dap = {
            enable = true;
          };
          extensions.crates-nvim.enable = true;
        };
      };
    };
  };
}
