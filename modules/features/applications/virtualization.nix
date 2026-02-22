{
  flake.modules.nixos.virtualization = {
    pkgs,
    config,
    ...
  }: let
    username = config.my.username;
  in {
    virtualisation.libvirtd.enable = true;
    my.persist.root.directories = [
      "/var/lib/libvirt"
    ];
    programs.virt-manager = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      swtpm
      tpm2-tools
    ];
    users.users.qemu-libvirtd.extraGroups = ["render"];
    users.users."${username}".extraGroups = ["libvirtd" "kvm" "render"];
  };
}
