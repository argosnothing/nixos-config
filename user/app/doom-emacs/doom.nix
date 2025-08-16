{ config, lib, pkgs, pkgs-stable, inputs, userSettings, systemSettings, ... }:
let
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
  dashboardLogo = ./. + "/nix-" + themePolarity + ".webp";
  doomDirBase = ./doom.d;

  stylixTheme = config.lib.stylix.colors.withHashtag {
    template  = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
    extension = ".el";
  };

  doomDir = pkgs.runCommand "doomdir" {} ''
    mkdir -p $out/themes
    ln -s ${./doom.d/doomdir/init.el}      $out/init.el
    ln -s ${./doom.d/doomdir/config.el}    $out/config.el
    ln -s ${./doom.d/doomdir/packages.el}  $out/packages.el
    ln -s ${
      config.lib.stylix.colors {
        template  = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
        extension = ".el";
      }
    } $out/themes/doom-stylix-theme.el
  '';
in
{
  programs.doom-emacs = {
   enable = true;
   doomDir = doomDir;
  };

  home.file.".emacs.d/dashboard-logo.webp".source = dashboardLogo;

  home.file.".emacs.d/system-vars.el".text = ''
  ;;; ~/.emacs.d/config.el -*- lexical-binding: t; -*-

  ;; Import relevant variables from flake into emacs

  (setq user-full-name "''+userSettings.name+''") ; name
  (setq user-username "''+userSettings.username+''") ; username
  (setq user-mail-address "''+userSettings.email+''") ; email
  (setq user-home-directory "/home/''+userSettings.username+''") ; absolute path to home directory as string
  (setq user-default-roam-dir "''+userSettings.defaultRoamDir+''") ; absolute path to home directory as string
  (setq system-nix-profile "''+systemSettings.profile+''") ; what profile am I using?
  (setq system-wm-type "''+userSettings.wmType+''") ; wayland or x11?
  (setq doom-font (font-spec :family "''+userSettings.font+''" :size 20)) ; import font
  (setq dotfiles-dir "''+userSettings.dotfilesDir+''") ; import location of dotfiles directory
 '';
}
