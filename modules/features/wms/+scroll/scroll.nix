{
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.scroll = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (config.my) cursor monitors desktop-shells;
    monitorConfigs =
      map (
        monitor:
          "output ${monitor.name} "
          + "resolution ${toString monitor.dimensions.width}x${toString monitor.dimensions.height}@${toString monitor.refresh}Hz "
          + "position ${toString monitor.position.x},${toString monitor.position.y}"
      )
      monitors;

    scroll-nix-config = ''
      ${builtins.concatStringsSep "\n" monitorConfigs}
      seat seat0 xcursor_theme ${cursor.name} ${toString cursor.size}
      set $menu ${desktop-shells.launcherCommand}
      exec ${lib.getExe' pkgs.dbus "dbus-update-activation-environment"} --systemd DISPLAY SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_DATA_DIRS && systemctl --user restart scroll-session.target
      exec ${lib.getExe pkgs.xorg.xrdb} -merge ~/.Xresources
    '';

    dots = config.impure-dir;
  in {
    imports =
      [
        inputs.scroll.nixosModules.default
      ]
      ++ (with flake.modules.nixos; [
        wm
        nemo
        icons
        gtk
      ]);
    my = {
      persist.home.directories = [
        ".config/scroll"
      ];
      session.name = "scroll";
      icons = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine";
      };
      cursor = {
        enable = true;
        name = "Simp1e-Dark";
      };
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        };
        scroll = {
          default = "gtk";
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];
    };

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

        # XDG desktop variables to set scroll as tse desktop
        export XDG_CURRENT_DESKTOP=scroll
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=scroll

        # Configure Electron to use Wayland instead of X11
        export ELECTRON_OZONE_PLATFORM_HINT=wayland

        # Set default browser
        export BROWSER=zen
      '';
    };

    hj.files.".config/scroll/config".source = dots + "/scroll/config";
    hj.files.".config/scroll/scroll-nix".text = scroll-nix-config;

    # systemd session target for scroll
    systemd.user.targets.scroll-session = {
      unitConfig = {
        Description = "scroll compositor session";
        BindsTo = ["graphical-session.target"];
        Wants = ["graphical-session-pre.target"] ++ config.my.startup-services;
        Before = config.my.startup-services;
        After = ["graphical-session-pre.target"];
      };
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
