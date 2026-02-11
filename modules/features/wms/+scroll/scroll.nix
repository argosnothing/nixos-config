{
  inputs,
  self,
  ...
}: let
  inherit (self) flake;
in {
  flake.modules.nixos.scroll = {pkgs, ...}: {
    imports = [
      inputs.scroll.nixosModules.default
    ];
    my.persist.home.directories = [
      ".config/scroll"
    ];
    programs.scroll = {
      enable = true;
      package = inputs.scroll.packages.${pkgs.system}.scroll-git;

      # Commands executed before scroll gets launched, see more examples here:
      # https://github.com/dawsers/scroll#environment-variables
      extraSessionCommands = ''
        # Tell QT, GDK and others to use the Wayland backend by default, X11 if not available
        export QT_QPA_PLATFORM="wayland;xcb"
        export GDK_BACKEND="wayland,x11"
        export SDL_VIDEODRIVER=wayland
        export CLUTTER_BACKEND=wayland

        # XDG desktop variables to set scroll as the desktop
        export XDG_CURRENT_DESKTOP=scroll
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=scroll

        # Configure Electron to use Wayland instead of X11
        export ELECTRON_OZONE_PLATFORM_HINT=wayland
      '';
    };

    # Enable Pipewire for screencasting and audio server
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };
}
