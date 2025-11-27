{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.xmonad = {pkgs, ...}: {
    imports = with flake.modules.nixos; [cursor];
    environment.systemPackages = with pkgs; [st];
    hj = {
      packages = with pkgs; [
        haskell-language-server
        xmobar
      ];
      files = {
        ".config/xmonad/xmonad.hs".source = ./xmonad.hs;
        ".config/xmobar/xmobarrc".source = ./xmobarrc;
      };
    };
    xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal];
    services = {
      picom.enable = true;
      displayManager = {
        ly.enable = true;
      };
      xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
        windowManager = {
          xmonad = {
            enable = true;
            enableContribAndExtras = true;
            extraPackages = hpkgs: [
              hpkgs.xmonad
              hpkgs.xmonad-extras
              hpkgs.xmonad-contrib
            ];
          };
        };
        displayManager.sessionCommands = ''
          xwallpaper --zoom ~/walls/wall1.png
        '';
      };
    };
  };
}
