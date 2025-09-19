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
            };

            languages.nix = {
              enable = true;
              extraDiagnostics.enable = true;
              format = {
                enable = true;
                type = "alejandra";
              };
              lsp = {
                servers = "nil";
                enable = true;
              };
            };

            languages.rust = {
              enable = true;
              crates.enable = true;
            };
          };
        };
      };
    };
  };
}
