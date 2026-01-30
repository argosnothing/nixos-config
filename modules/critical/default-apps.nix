{
  flake.modules.nixos.home = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf ((config.my.default.apps != {}) || (config.my.default.associations != {})) {
      hj.xdg.config.files."mimeapps.list" = {
        generator = lib.generators.toINI {};
        value = {
          "Default Applications" = config.my.default.apps;
          "Added Associations" = lib.mapAttrs (_: apps: lib.concatStringsSep ";" apps + ";") config.my.default.associations;
        };
      };
    };
  };
}
