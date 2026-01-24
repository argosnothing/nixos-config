{inputs, ...}: {
  flake.modules.nixos.zen-browser = {pkgs, ...}: {
    environment.systemPackages = [inputs.zen-browser.${pkgs.system}.default];
    my.persist.home.directories = [".config/zen"];
  };
}
