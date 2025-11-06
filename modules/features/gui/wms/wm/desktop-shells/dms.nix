{inputs, ...}: {
  flake.modules.nixos.dms = {
    config,
    lib,
    ...
  }: let
    colors = config.lib.stylix.colors.withHashtag;
    is-dark = config.my.theme.polarity == "dark";
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
        name = "Stylix Sourced Theme";
        isDark = (config.stylix.polarity or "dark") == "dark";
        primary = colors.base0D;
        primaryText =
          if is-dark
          then colors.base07
          else colors.base00;
        primaryContainer = colors.base0D;
        secondary = colors.base0E;
        surface = colors.base01;
        surfaceText =
          if is-dark
          then colors.base05
          else colors.base05;
        surfaceVariant = colors.base02;
        surfaceVariantText =
          if is-dark
          then colors.base04
          else colors.base03;
        surfaceTint = colors.base0D;
        background = colors.base00;
        backgroundText =
          if is-dark
          then colors.base05
          else colors.base05;
        outline =
          if is-dark
          then colors.base03
          else colors.base04;
        surfaceContainer = colors.base02;
        surfaceContainerHigh = colors.base03;
        surfaceContainerHighest = colors.base04;
        error = colors.base08;
        warning = colors.base0A;
        info = colors.base0D;
        matugen_type = "scheme-expressive";
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
