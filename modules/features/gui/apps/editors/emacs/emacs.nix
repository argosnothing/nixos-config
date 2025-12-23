{inputs, ...}: {
  flake.modules.nixos.emacs = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.emacs
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
          ".local/share/nix-doom"
          ".emacs.d"
        ];
      };
    };
  };
}
