{
  flake.modules.nixos.iamb = {pkgs, ...}: {
    my.persist.home.directories = [".config/iamb"];
    environment.systemPackages = with pkgs; [iamb];
  };
}
