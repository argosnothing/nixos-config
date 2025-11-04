{inputs, ...}: {
  flake.modules.nixos.dms = {
    imports = [
    ];
    hm = {
      imports = [
        inputs.dms.homeModules.dankMaterialShell.default
      ];
      programs.dankMaterialShell = {
        enable = true;
        enableSystemd = true;
      };
    };
  };
}
