{
  flake.modules.nixos.microsoft-edge = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      microsoft-edge
    ];
    my.persist.home.directories = [
      ".config/microsoft-edge"
    ];
  };
}
