{
  flake.modules.nvf.default = {
    vim = {
      #LSP Direct Configs
      lsp = {
        enable = true;
      };
      languages = {
        nix = {
          enable = true;
          extraDiagnostics = {
            enable = true;
            types = ["deadnix" "statix"];
          };
          format = {
            enable = true;
            type = "alejandra";
          };
          lsp = {
            servers = ["nil" "nixd"];
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
