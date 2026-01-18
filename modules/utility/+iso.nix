{
  inputs,
  self,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.iso = {
    config,
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
      [
        "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      ]
      ++ (with flake.modules.nixos; [
        nix-settings
      ]);

    nixpkgs.hostPlatform = mkDefault "x86_64-linux";

    # Basic user setup for live environment
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
      systemPackages = with pkgs; [
        kickstartScript
        git
        jq
        vim
        parted
        dosfstools
        usbutils
        nh
      ];

      # Bundle the AGE key into the ISO at a known location
      etc."kickstart/age/keys.txt".source = bundledAgeKey;
    };

    # Copy the bundled AGE key to user's home on activation
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
}
