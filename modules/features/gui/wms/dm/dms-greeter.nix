{inputs, ...}: {
  flake.modules.nixos.dms-greeter = {lib, ...}: {
    imports = [
      inputs.dms.nixosModules.greeter
    ];
    programs.dankMaterialShell.greeter = {
      enable = true;
      compositor = {
        name = "mango";
      };
    };
  };
}
