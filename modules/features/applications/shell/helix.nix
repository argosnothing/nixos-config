{inputs, ...}: {
  flake.modules.nixos.helix = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.helix
      pkgs.nnd
    ];

    my.persist.home = {
      directories = [
        ".config/helix/themes"
        ".local/share/helix"
      ];

      cache.directories = [
        ".cache/helix"
      ];
    };

    hj.files = let
      dotsDir = config.impure-dir;
    in {
      ".config/helix/config.toml".source = dotsDir + "/helix/config.toml";
      ".config/helix/languages.toml".source = dotsDir + "/helix/languages.toml";
    };
  };
}
