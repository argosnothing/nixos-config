{inputs, ...}: {
  flake.modules.nixos.dms-greeter = {lib, ...}: {
    imports = [
      inputs.dms.nixosModules.greeter
    ];
    my.persist.root.directories = [
      "var/lib/dmsgreeter"
    ];
    programs.dankMaterialShell.greeter = {
      enable = true;
      compositor = {
        name = "mango";
      };
    };
  };
}
