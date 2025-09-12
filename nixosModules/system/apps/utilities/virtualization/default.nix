{pkgs, lib, settings, ...}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemuOvmf = true;
  programs.virt-manager = {
    enable = true;
  };
  users.users."${settings.username}".extraGroups = [ "libvirtd" "kvm"];
}
