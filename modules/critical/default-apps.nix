{
  flake.modules.nixos.home = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf ((config.my.defaultApps.default != {}) || (config.my.defaultApps.associations != {})) {
      hj.xdg.config.files."mimeapps.list" = {
        generator = lib.generators.toINI {};
        value = {
          "Default Applications" = config.my.defaultApps.default;
          "Added Associations" = lib.mapAttrs (_: apps: lib.concatStringsSep ";" apps + ";") config.my.defaultApps.associations;
        };
      };
    };
  };
}
