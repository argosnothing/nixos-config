{inputs, ...}: {
  flake.modules.nixos.spicetify = {
    #imports = [inputs.spicetify-nix.nixosModules.default];
    #programs.spicetify = {
    #  enable = true;
    #};
  };
}
