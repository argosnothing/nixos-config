### Critical Flake Infrastructure
# A collection of very important dendritic modules for my flake, kept as modules for special
# hosts like the wsl that handle some of these options through the wsl module :)
{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];
  flake.modules.nixos = {
    grub = {pkgs, ...}: let
      inherit (pkgs.stdenv.hostPlatform) system;
    in {
      boot = {
        plymouth.enable = true;
        loader = {
          grub = {
            enable = true;
            efiSupport = true;
            devices = ["nodev"];
          };
          efi.canTouchEfiVariables = true;
        };
        consoleLogLevel = 3;
        kernelParams = [
          "quiet"
          "loglevel=3"
          "systemd.show_status=false"
          "rd.udev.log_priority=3"
          "vt.global_cursor_default=0" # optional, hides blinking cursor
        ];
        kernel.sysctl."kernel.printk" = "3 3 3 3";
      };
    };

    misc = {pkgs, ...}: {
      my.persist.root.directories = [
        "/etc/NetworkManager/system-connections"
      ];

      environment = {
        shells = with pkgs; [zsh];

        systemPackages = with pkgs; [
          # criticals
          sops
          dbus
          hdparm

          # must haves
          bottom
          nh
          lazygit
          alejandra
          git
          unzip
          openssl
          usbutils

          # audios
          pipewire
          pamix
          grimblast
          playerctl

          # others
          brightnessctl
        ];

        variables = {
          ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          NIXOS_OZONE_WL = "1";
          ELECTRON_ENABLE_LOGGING = "0";
          EDITOR = "hx";
          VISUAL = "hx";
        };
      };

      systemd.user.extraConfig = ''
        DefaultEnvironment="NIXOS_OZONE_WL=1"
        DefaultEnvironment="ELECTRON_OZONE_PLATFORM_HINT=wayland"
        DefaultEnvironment="OZONE_PLATFORM=wayland"
      '';
    };

    user = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (lib) types mkOption;
      inherit (types) str;
      inherit (config.my) username;
    in {
      options.user = {
        name = mkOption {
          type = str;
          default = username;
        };
      };
      config = {
        programs.fish.enable = true;
        users = {
          users.root.initialPassword = "password";
          users.${username} = {
            isNormalUser = true;
            extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
            hashedPasswordFile = config.sops.secrets."pc_password".path;
          };
          defaultUserShell = pkgs.bash;
        };
      };
    };

    networking = {config, ...}: {
      networking = {
        hostName = config.my.hostname;
        networkmanager.enable = true;
        nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
      };

      time.timeZone = "America/New_York";
      i18n.defaultLocale = "en_US.UTF-8";
    };

    nix-settings = {pkgs, ...}: {
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

    pipewire = {
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
