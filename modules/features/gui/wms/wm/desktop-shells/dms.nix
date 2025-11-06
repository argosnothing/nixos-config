{inputs, ...}: {
  flake.modules.nixos.dms = {
    config,
    lib,
    ...
  }: let
    colors = config.lib.stylix.colors.withHashtag;
  in {
    my = {
      persist = {
        home.cache.directories = [
          ".cache/DankMaterialShell"
        ];
        home.directories = [
          ".config/DankMaterialShell"
          ".local/state/DankMaterialShell"
        ];
      };
      desktop-shells = {
        name = "dms";
        execCommand = "dms run";
        launcherCommand = "dms ipc call spotlight toggle";
      };
    };
    hj.files.".config/DankMaterialShell/stylix.json" = {
      generator = lib.generators.toJSON {};
      value = {
        "name" = "Stylix Sourced theme";
        "primary" = colors.base0D;
        "primaryText" = colors.base07;
        "surface" = colors.base01;
        "surfaceText" = colors.base05;
        "background" = colors.base00;
        "backgroundText" = colors.base05;
        "outline" = colors.base04;
        "mutagen_type" = "scheme-tonal-spot";
      };
    };
    hm = {
      imports = [
        inputs.dms.homeModules.dankMaterialShell.default
      ];
      programs.dankMaterialShell = {
        enable = true;
        enableSystemd = true;
      };
    };
  };
}
