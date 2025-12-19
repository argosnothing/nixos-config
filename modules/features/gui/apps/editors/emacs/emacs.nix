{inputs, ...}: {
  flake.modules.nixos.emacs = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.emacs
    ];
    my.persist = {
      home = {
        ##################################
        # cache.files = [                #
        #   ".cache/doom/lsp-session"    #
        # ];                             #
        # cache.directories = [          #
        #   ".cache/doom/nix/projectile" #
        #   ".cache/doom/nix/eln"        #
        #   ".cache/doom/autosave"       #
        #   ".cache/doom/org"            #
        #   ".cache/doom/backup"         #
        # ];                             #
        ##################################
        cache.directories = [
          ".cache/doom"
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
