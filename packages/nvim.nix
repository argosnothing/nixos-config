{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    grammars = map (a: pkgs.lib.concatStrings ["tree-sitter-" a]) [
      "bash"
      "lua"
      "nix"
      "python"
      "nu"
      "json"
      "go"
      "rust"
      "markdown"
      "diff"
      "yang"
    ];

    startPlugins = builtins.attrValues {
      inherit
        (pkgs.vimPlugins)
        mini-nvim
        snacks-nvim
        which-key-nvim
        neovim-ayu
        luasnip
        friendly-snippets
        nvim-dap
        rose-pine
        cord-nvim
        direnv-vim
        ;
      treesitter =
        pkgs.vimPlugins.nvim-treesitter.withPlugins (p: map (a: p.${a}) grammars);
    };

    lazyPlugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      conform-nvim
      oil-nvim
      hop-nvim
      gitsigns-nvim
      todo-comments-nvim
      blink-cmp
      claude-code-nvim
      nvim-dap-ui
      nvim-dap-python
      kanso-nvim
      bamboo-nvim
      kanagawa-nvim
      gruvbox-nvim
      tokyonight-nvim
      catppuccin-nvim
      dracula-nvim
      everforest
      nightfox-nvim
      nord-nvim
      onedark-nvim
      material-nvim
      sonokai
      cyberdream-nvim
      melange-nvim
      nightfly
      monokai-pro-nvim
      modus-themes-nvim
      github-nvim-theme
      fleet-theme-nvim
      oxocarbon-nvim
    ];

    extraBinPath = with pkgs; [
      lazygit
      fd
      nil
      nixd
      alejandra
      lua-language-server
      stylua
      basedpyright
      ruff
      rust-analyzer
      lldb
      vscode-json-languageserver
    ];

    configDir = "${../.impure/nvim}";
    impureConfigDir = "/home/salivala/nixos-config/.impure/nvim";
  in {
    packages.nvim = inputs.mnw.lib.wrap pkgs {
      aliases = [
        "vi"
        "vim"
        "nv"
      ];
      extraBinPath = extraBinPath;
      initLua = builtins.readFile (configDir + "/init.lua");
      plugins = {
        start = startPlugins;
        opt = lazyPlugins;
        dev.config = {
          pure = configDir;
          impure = impureConfigDir;
        };
      };
      providers.python3 = {
        enable = true;
        extraPackages = p:
          with p; [
            debugpy
            pynvim
          ];
      };
    };
  };
}
