{settings, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.enable = true;
  programs.virt-manager = {
    enable = true;
  };
  users.users."${settings.username}".extraGroups = ["libvirtd" "kvm"];

  custom.persist.root.directories = ["/var/lib/libvirt"];
  custom.persist.root.cache.directories = ["/var/cache/libvirt"]
}
