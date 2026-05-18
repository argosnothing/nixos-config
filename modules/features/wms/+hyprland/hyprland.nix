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
          monitor: ''
            hl.monitor({
                output = "${monitor.name}",
                mode = "${toString monitor.dimensions.width}x${toString monitor.dimensions.height}@${toString monitor.refresh}",
                position = "${toString monitor.position.x}x${toString monitor.position.y}",
                scale = ${toString monitor.scale},
            })
          ''
        )
        monitors;

      dbus-cmd = lib.getExe' pkgs.dbus "dbus-update-activation-environment";
      xrdb-cmd = lib.getExe pkgs.xorg.xrdb;

      hyprland-nix-config = ''
        ${builtins.concatStringsSep "\n" monitorConfigs}
        hl.env("XCURSOR_THEME", "${cursor.name}")
        hl.env("XCURSOR_SIZE", "${toString cursor.size}")
        hl.env("HYPRCURSOR_SIZE", "${toString cursor.size}")
        hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
        menu = "${desktop-shells.launcherCommand}"
        hl.on("hyprland.start", function()
            hl.exec_cmd("${dbus-cmd} --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart hyprland-session.target")
            hl.exec_cmd("${xrdb-cmd} -merge ~/.Xresources")
            hl.exec_cmd("${desktop-shells.execCommand}")
        end)
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
        wm.hyprland.active-config = "main";
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

      hj.files.".config/hypr/hyprland.lua".source = dots + "/hyprland/${active-config.route}/hyprland.lua";
      hj.files.".config/hypr/hyprland-nix.lua".text = hyprland-nix-config;

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
