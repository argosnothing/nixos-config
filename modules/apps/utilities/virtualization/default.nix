{settings, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.enable = true;
  programs.virt-manager = {
    enable = true;
  };
  users.users."${settings.username}".extraGroups = ["libvirtd" "kvm"];
}
