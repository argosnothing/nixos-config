{
  config,
  inputs,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.hyprland = {
    pkgs,
    config,
    lib,
    ...
  }:
    with lib; let
      inherit (config.my) cursor monitors desktop-shells;
      active-config = config.my.wm.hyprland.configs.${config.my.wm.hyprland.active-config};

      monitorConfigs =
        map (
          monitor:
            "monitor = ${monitor.name},"
            + "${toString monitor.dimensions.width}x${toString monitor.dimensions.height}@${toString monitor.refresh},"
            + "${toString monitor.position.x}x${toString monitor.position.y},"
            + "${toString monitor.scale}"
        )
        monitors;

      hyprland-nix-config = ''
        ${builtins.concatStringsSep "\n" monitorConfigs}
        env = XCURSOR_THEME,${cursor.name}
        env = XCURSOR_SIZE,${toString cursor.size}
        env = HYPRCURSOR_SIZE,${toString cursor.size}
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
        $menu = ${desktop-shells.launcherCommand}
        exec-once = ${lib.getExe' pkgs.dbus "dbus-update-activation-environment"} --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart hyprland-session.target
        exec-once = ${lib.getExe pkgs.xorg.xrdb} -merge ~/.Xresources
      '';

      nixos-modules = with flake.modules.nixos; [
        wm
        nemo
        icons
        gtk
      ];

      dots = config.impure-dir;
    in {
      my = {
        wm.hyprland.active-config = "testing";
        session.name = "hyprland";
        icons = {
          package = pkgs.rose-pine-icon-theme;
          name = "rose-pine";
        };
        cursor = {
          enable = true;
          name = "Simp1e-Dark";
        };
        persist.home = {
          directories = [
            ".config/hypr"
          ];
        };
      };
      imports = nixos-modules;
      programs.hyprland = {
        enable = true;
        package = active-config.package;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };

      hj.files.".config/hypr/hyprland.conf".source = dots + "/hyprland/${active-config.route}/hyprland.conf";
      hj.files.".config/hypr/hyprland-nix.conf".text = hyprland-nix-config;

      # systemd session target for hyprland
      systemd.user.targets.hyprland-session = {
        unitConfig = {
          Description = "Hyprland compositor session";
          BindsTo = ["graphical-session.target"];
          Wants = ["graphical-session-pre.target"] ++ config.my.startup-services;
          Before = config.my.startup-services;
          After = ["graphical-session-pre.target"];
        };
      };
    };
}
