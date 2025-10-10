{
  settings,
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.virtualization) enable;
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.modules.gui.virtualization = {
    enable = mkEnableOption "Enable Virtualization";
  };
  config = mkIf enable {
    virtualisation.libvirtd.enable = true;
    my.persist.root.directories = [
      "/var/lib/libvirt"
    ];
    programs.virt-manager = {
      enable = true;
    };
    users.users.qemu-libvirtd.extraGroups = ["render"];
    users.users."${settings.username}".extraGroups = ["libvirtd" "kvm" "render"];
  };
}
