{ lib, pkgs, config, inputs, userSettings, ... }:
let
  overridePath =
    ../../../themes/${userSettings.theme}/user/app/vesktop.css;
  hasThemeOverride = builtins.pathExists overridePath;
in
{
  stylix.targets.vesktop.enable = !hasThemeOverride;
  stylix.targets.vencord.enable = !hasThemeOverride;

  programs.vesktop.enable = true;

   programs.vesktop.vencord = lib.mkIf hasThemeOverride {
    themes.${userSettings.theme} = builtins.readFile overridePath;
    settings.enabledThemes = [ "${userSettings.theme}.css" ];
  };
}
