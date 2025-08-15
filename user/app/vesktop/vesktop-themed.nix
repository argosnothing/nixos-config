# vesktop-custom.nix
{ config, lib, pkgs, ... }:

{
  stylix.targets.vesktop.enable = false;
  stylix.targets.vencord.enable = false;

  #xdg.configFile."vesktop/settings/settings.json".text =

  programs.vesktop = {
    enable = true;
    vencord = {
       themes.gruvbox-dark = builtins.readFile ./themes/gruvbox-dark.theme.css;
       settings.enabledThemes = [ "gruvbox-dark.css" ];
    };
  };
}
