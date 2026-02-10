{
  flake.modules.nixos.obs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
    my.persist.home.directories = [
      ".config/obs-studio"
    ];
  };
}
