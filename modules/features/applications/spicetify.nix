{inputs, ...}: {
  flake.modules.nixos.spicetify = {pkgs, ...}: {
    imports = [inputs.spicetify-nix.nixosModules.default];
    environment.systemPackages = with pkgs; [spicetify-cli];
    programs.spicetify = {
      enable = true;
    };
  };
}
