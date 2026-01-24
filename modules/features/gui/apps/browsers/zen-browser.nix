{inputs, ...}: {
  flake.modules.nixos.zen-browser = {pkgs, ...}: {
    environment.systemPackages = [inputs.zen-browser.packages.${pkgs.system}.default];
    my.persist.home.directories = [".zen"];
  };
}
