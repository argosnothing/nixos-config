{
  inputs,
  lib,
  config,
  self,
  ...
}: let
  inherit (config) flake;

  mk-pkgs-stable = system:
    import inputs.nixpkgs-stable {
      inherit system;
      config = {
        allowUnfree = true;
        allowAliases = true;
      };
    };

  mkWsl = system: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        config.flake.modules.nixos.cursor
        inputs.nixos-wsl.nixosModules.default
        config.flake.modules.nixos.${name}
        {
          my.hostname = "nixos";
          networking.hostName = lib.mkDefault name;
          nixpkgs = {
            hostPlatform = lib.mkDefault system;
            overlays = config.flake.nixpkgs.overlays;
            config = {
              allowUnfree = true;
              showAliases = true;
            };
          };
          system.stateVersion = "25.05";
        }
      ];
    };

  mkNixos = system: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        pkgs-stable = mk-pkgs-stable system;
      };
      modules = [
        config.flake.modules.nixos.base
        config.flake.modules.nixos.cursor
        config.flake.modules.nixos.${name}
        {
          my.hostname = name;
          networking.hostName = lib.mkDefault name;
          nixpkgs = {
            hostPlatform = lib.mkDefault system;
            overlays = config.flake.nixpkgs.overlays;
            config = {
              allowUnfree = true;
              showAliases = true;
              allowBroken = true;
              permittedInsecurePackages = [
                "libsoup-2.74.3"
              ];
            };
          };
          system.stateVersion = "25.05";
        }
      ];
    };

  linux = mkNixos "x86_64-linux";
  wsl = mkWsl "x86_64-linux";
in {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake = {
    nixpkgs.overlays = [
      (_: super: {
        inherit (super.stdenv.hostPlatform) system;
      })
    ];

    lib = {
      mk-os = {inherit mkNixos linux wsl;};

      hostsBySystem = system: let
        where =
          if lib.hasSuffix "darwin" system
          then inputs.self.darwinConfigurations
          else inputs.self.nixosConfigurations;
        sameSystem = lib.filterAttrs (_: v: v.config.nixpkgs.hostPlatform.system == system) where;
      in
        lib.attrNames sameSystem;

      move = targetPath: let
        sourcePath = inputs.self + "/${targetPath}";
        normalizedTarget =
          if builtins.substring ((builtins.stringLength targetPath) - 1) 1 targetPath == "/"
          then builtins.substring 0 ((builtins.stringLength targetPath) - 1) targetPath
          else targetPath;
      in {"${normalizedTarget}".source = sourcePath;};

      move-script = {
        pkgs,
        targetPath,
      }: let
        sourceDir = inputs.self + "/" + targetPath;
        files = builtins.attrNames (builtins.readDir sourceDir);
        mkDrv = f: let
          m = builtins.match "^(.*)\\.[^\\.]+$" f;
          name = builtins.elemAt m 0;
          src = builtins.concatStringsSep "/" [(toString sourceDir) f];
        in
          pkgs.writeShellScriptBin name src;
      in
        map mkDrv files;

      unfree-module = names: {lib, ...}: {
        nixpkgs.config.allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) names;
      };
    };

    modules.nixos.iso = {
      pkgs,
      lib,
      ...
    }: let
      inherit (lib) mkForce mkDefault;
      username = "salivala";
      kickstartScript = pkgs.writeShellApplication {
        name = "kickstart";
        runtimeInputs = with pkgs; [jq coreutils util-linux parted dosfstools zfs git nixos-install-tools];
        checkPhase = "";
        text = builtins.readFile "${self}/kickstart.sh";
      };
      bundledAgeKey = /. + builtins.getEnv "HOME" + "/.config/sops/age/keys.txt";
    in {
      imports =
        ["${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"]
        ++ (with flake.modules.nixos; [nix-settings]);

      nixpkgs.hostPlatform = mkDefault "x86_64-linux";
      users.users.${username} = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
        initialPassword = "kickstart";
        shell = pkgs.bashInteractive;
      };
      security.sudo.wheelNeedsPassword = false;
      services.getty.autologinUser = mkForce username;
      networking = {
        networkmanager.enable = true;
        wireless.enable = mkForce false;
      };
      environment = {
        systemPackages = with pkgs; [kickstartScript git jq vim parted dosfstools usbutils nh];
        etc."kickstart/age/keys.txt".source = bundledAgeKey;
      };
      system.activationScripts.kickstart-age-key = lib.stringAfter ["users"] ''
        TARGET="/home/${username}/.config/sops/age"
        mkdir -p "$TARGET"
        cp /etc/kickstart/age/keys.txt "$TARGET/keys.txt"
        chmod 700 "$TARGET"
        chmod 600 "$TARGET/keys.txt"
        chown -R ${username}:users "/home/${username}/.config"
      '';
      image.fileName = mkDefault "kickstart-nixos.iso";
      isoImage.volumeID = "KICKSTART";
    };
  };

  config.systems = import inputs.systems;
}
