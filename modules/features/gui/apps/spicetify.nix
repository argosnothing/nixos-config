{
  flake.modules.nixos.spicetify = {inputs, pkgs, ...}:{
    hm = {
      imports = [ inputs.spicetify-nix.homeManagerModules.default];
    };
    programs.spicetify = 
      let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in {enable = true; theme = spicePkgs.themes.catpuccin;};
  };
}
