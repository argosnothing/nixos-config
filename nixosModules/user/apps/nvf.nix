{pkgs, inputs, lib, ...}: {
  options = {
    nvf.enable = lib.mkEnableOption "Enable nvf (Neovim From Flake)" true;
  }
  home.packages = [
    inputs.self.packages.${pkgs.system}.nvf
  ];
}
