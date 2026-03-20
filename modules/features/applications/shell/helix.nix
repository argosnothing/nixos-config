{inputs, ...}: {
  flake.modules.nixos.helix = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs;
      [
        nixd
        nil
        lldb
        gdb
        bash-language-server
      ]
      # ++ [inputs.helix.packages.${pkgs.system}.default];
      ++ [
        (inputs.helix-steel.packages.${pkgs.system}.default.overrideAttrs {
          cargoBuildFeatures = ["steel"];
        })
        pkgs.steel
      ];
    my.persist.home.directories = [
      ".config/helix/themes"
    ];

    hj.files = let
      dotsDir = config.impure-dir;
    in {
      ".config/helix/config.toml".source = dotsDir + "/helix/config.toml";
      ".config/helix/languages.toml".source = dotsDir + "/helix/languages.toml";
      ".config/helix/helix.scm".source = dotsDir + "/helix/helix.scm";
      ".config/helix/init.scm".source = dotsDir + "/helix/init.scm";
      ".config/helix/cogs".source = dotsDir + "/helix/cogs";
    };
  };
}
