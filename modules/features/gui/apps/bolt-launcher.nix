{
  flake.modules.nixos.bolt-launcher = {pkgs, ...}: {
    my.persist.home.directories = [
      ".local/share/bolt-launcher"
    ];
    environment.systemPackages = with pkgs; [
      bolt-launcher
    ];
  };
}
