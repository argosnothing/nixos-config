{config, ...}: let
  inherit (config.flake) settings;
in {
  flake.modules.nixos.winboat = {pkgs, ...}: {
    users.users.${settings.username} = {
      extraGroups = ["docker"];
    };
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm = {
            enable = false;
          };
        };
      };
      docker = {
        enable = true;
        enableOnBoot = true;
      };
    };
    my.persist.home.directories = [
      ".winboat"
      ".config/winboat"
      "Windows"
    ];
    environment.systemPackages = [
      pkgs.winboat
      pkgs.freerdp
    ];
  };
}
