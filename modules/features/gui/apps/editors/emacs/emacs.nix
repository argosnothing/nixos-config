{inputs, ...}: {
  flake.modules.nixos.emacs = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.emacs
      pkgs.fd
    ];
    my.persist = {
      home = {
        cache.directories = [
          ".cache/doom"
          "temacs"
        ];
        directories = [
          ".config/emacs"
          ".config/doom"
          "org"
          ".local/share/nix-doom"
          ".emacs.d"
        ];
      };
    };
  };
}
