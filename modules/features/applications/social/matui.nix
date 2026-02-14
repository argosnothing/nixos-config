{inputs, ...}: {
  flake.modules.nixos.matui = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.matui.packages.${pkgs.system}.default
    ];
    my.persist.home.directories = [
      ".config/matui"
    ];
  };
}
