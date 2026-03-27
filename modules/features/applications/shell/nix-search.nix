{inputs, ...}: {
  flake.modules.nixos.nix-search = {
    config,
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      television
      nix-search-tv
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.ns
    ];

    hj.files.".config/television/cable/nix.toml".text = let
      nstv = lib.getExe pkgs.nix-search-tv;
    in ''
      [metadata]
      name = "nix"

      [source]
      command = "${nstv} print"

      [preview]
      command = "${nstv} preview {0}"
    '';

    hj.xdg.config.files."nix-search-tv/config.json" = {
      generator = lib.generators.toJSON {};
      value = {
        indexes = ["nixpkgs" "nixos" "home-manager" "nur" "noogle"];
      };
    };

    my.persist.home.cache.directories = [
      ".cache/nix-search-tv"
    ];
  };
}
