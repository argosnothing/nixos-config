### Authentication
# Curtesy of Iynaix and their magical flake
# https://github.com/iynaix/dotfiles/blob/b86f6e58107c73260440dda149fc514259bb2ac5/modules/auth.nix#L34
{lib, ...}: {
  flake.modules.nixos.auth = {
    config,
    pkgs,
    ...
  }: {
    config = lib.mkMerge [
      # keyring settings
      {
        services.gnome.gnome-keyring.enable = true;
        security.pam.services.login.enableGnomeKeyring = true;
      }

      # WM agnostic polkit authentication agent
      {
        systemd.user.services.polkit-gnome = {
          wantedBy = ["graphical-session.target"];

          unitConfig = {
            Description = "GNOME PolicyKit Agent";
            After = ["graphical-session.target"];
            PartOf = ["graphical-session.target"];
          };

          serviceConfig = {
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          };
        };
      }
      {
        security = {
          polkit.enable = true;
          # i can't type
          sudo.extraConfig = "Defaults passwd_tries=10";
        };

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        environment.variables = {
          GNUPGHOME = "${config.hj.xdg.data.directory}/.gnupg";
        };

        programs.gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };

        # persist keyring and misc other secrets
        my.persist = {
          root = {
            files = [
              "/etc/ssh/ssh_host_rsa_key"
              "/etc/ssh/ssh_host_rsa_key.pub"
              "/etc/ssh/ssh_host_ed25519_key"
              "/etc/ssh/ssh_host_ed25519_key.pub"
            ];
          };
          home = {
            directories = [
              ".pki"
              ".ssh"
              ".local/share/.gnupg"
              ".local/share/keyrings"
            ];
          };
        };
      }
      {
        services.displayManager = {
          defaultSession = config.my.session.name;
        };
      }
    ];
  };
}
