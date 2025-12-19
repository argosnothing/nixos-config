{inputs, ...}: {
  flake.modules.nixos.emacs = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.nix-doom-emacs-unstraightened.overlays.default];
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.emacs
    ];
    my.persist = {
      home = {
        cache.files = [
          ".cache/doom/treemacs-persist"
        ];
        cache.directories = [
          ".cache/doom/nix/projectile"
          ".cache/doom/nix/eln"
          ".cache/doom/autosave"
          ".cache/doom/org"
          ".cache/doom/backup"
        ];
        directories = [
          ".config/emacs"
          ".config/doom"
          ".local/share/nix-doom"
          ".emacs.d"
        ];
      };
    };
  };
}
