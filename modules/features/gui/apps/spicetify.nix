{inputs, ...}: {
  flake.modules.nixos.spicetify = {pkgs, ...}: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [inputs.spicetify-nix.nixosModules.default];
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.ziro;
      colorScheme = "rose-pine-moon";
    };
  };
}
