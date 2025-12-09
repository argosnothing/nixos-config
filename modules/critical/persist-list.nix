{
  flake.modules.nixos.impermanence = {
    my.persist = {
      home = {
        cache.directories = [
          ".cache/nix"
        ];
      };
    };
  };
}
