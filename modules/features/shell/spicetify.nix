{
  flake.modules.nixos.spicetify = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [spicetify-cli];
  };
}
