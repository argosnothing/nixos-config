{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.nvf.enable {
    programs = {
      nvf = {
        settings = {
          vim = {
            #LSP Direct Configs
            lsp = {
              enable = true;
            };
            languages = {
              enableTreesitter = true;

              nix = {
                enable = true;
                extraDiagnostics.enable = true;
                format = {
                  enable = true;
                  type = "alejandra";
                };
                lsp = {
                  server = "nil";
                  enable = true;
                };
              };

              markdown = {
                enable = true;
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
                crates.enable = true;
              };
            };
          };
        };
      };
    };
  };
}
