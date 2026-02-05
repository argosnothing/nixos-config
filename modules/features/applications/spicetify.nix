{inputs, ...}: {
  flake.modules.nixos.spicetify = {pkgs, ...}: {
    imports = [inputs.spicetify-nix.nixosModules.default];
    environment.systemPackages = with pkgs; [spicetify-cli];
    my.persist.home.directories = [".config/spotify"];
    my.persist.home.cache.directories = [".cache/spotify"];
    programs.spicetify = {
      enable = true;
    };
  };
}
