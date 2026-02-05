{
  flake.modules.nixos.element-desktop = {
    hm = {
      programs.element-desktop = {
        enable = true;
      };
    };
  };
}
