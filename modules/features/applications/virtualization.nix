{config, ...}: {
  flake.modules.nixos.virtualization = {config, ...}: let
    username = config.user.name;
  in {
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
