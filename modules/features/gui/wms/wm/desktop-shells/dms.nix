{inputs, ...}: {
  flake.modules.nixos.dms = {
    imports = [
    ];
    hm = {
      imports = [
        inputs.dms.homeModules.DankMaterialShell.default
      ];
      programs.dankMaterialShell = {
        enable = true;
        enableSystemd = true;
      };
    };
  };
}
