{
  flake.modules.nixos.winboat = {
    pkgs,
    inputs,
    flake,
    ...
  }: {
    users.users.${flake.settings.username} = {
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
      inputs.winboat.winboat
      pkgs.freerdp
    ];
  };
}
