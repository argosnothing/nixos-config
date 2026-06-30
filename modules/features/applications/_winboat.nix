{
  flake.modules.nixos.winboat = {
    pkgs,
    config,
    ...
  }: {
    users.users.${config.my.username} = {
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
    environment.systemPackages = [
      pkgs.winboat
      pkgs.freerdp
    ];
  };
}
