## doing it this why should mean fuck all but whatever why not
let
  flake.modules.nixos = {inherit nix-settings;};

  nix-settings = {
    pkgs,
    inputs,
    ...
  }: {
    nix = {
      settings = {
        trusted-users = ["root" "@wheel"];
        experimental-features = ["nix-command" "pipe-operators" "flakes"];
        download-buffer-size = 268435456;
        substituters = [
          "https://cache.nixos.org/"
        ];
        trusted-public-keys = [
          "niri.cachix.org-1:T+M3pBd3DkFdBvA+SviyNv0glk+rPZsAocRAGYMddww="
        ];
      };
      package = pkgs.nixVersions.latest;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
in {
  inherit flake;
}
