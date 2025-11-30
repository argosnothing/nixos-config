{config, ...}: let
  inherit (config) flake;
  inherit (flake.settings) username;
in {
  flake.modules.nixos.virtualization = {
    virtualisation.libvirtd.enable = true;
    my.persist.root.directories = [
      "/var/lib/libvirt"
    ];
    programs.virt-manager = {
      enable = true;
    };
    users.users.qemu-libvirtd.extraGroups = ["render"];
    users.users."${username}".extraGroups = ["libvirtd" "kvm" "render"];
  };
}
