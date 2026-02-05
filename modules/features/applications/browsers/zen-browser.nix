{inputs, ...}: {
  flake.modules.nixos.zen-browser = {pkgs, ...}: {
    environment.systemPackages = [inputs.zen-browser.packages.${pkgs.system}.default];
    my.persist.home.directories = [".zen"];
    my.persist.home.cache.directories = [".cache/zen"];
    my.default = let
      name = "zen-beta";
    in {
      apps = {
        "text/html" = "${name}.desktop";
        "x-scheme-handler/http" = "${name}.desktop";
        "x-scheme-handler/https" = "${name}.desktop";
      };
      associations = {
        "text/html" = ["${name}.desktop"];
        "x-scheme-handler/http" = ["${name}.desktop"];
        "x-scheme-handler/https" = ["${name}.desktop"];
      };
    };
  };
}
