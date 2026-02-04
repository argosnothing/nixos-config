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
      hyprland-pkg = inputs.hyprland-test.packages.${pkgs.system}.hyprland.overrideAttrs (old: {
        stdenv = pkgs.clangStdenv;
        NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -O1";
      });

      plugin-dir = pkgs.symlinkJoin {
        name = "hyprland-plugins";
        paths = [
          inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
        ];
      };

      # Generate Nix-interpolated configuration
      inherit (config.my) cursor monitors desktop-shells;

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

      dots = config.hj.impure.dotsDir;
    in {
      imports = nixos-modules;
      environment.sessionVariables = {HYPR_PLUGIN_DIR = plugin-dir;};
      my = {
        session.name = "hyprland";
        icons = {
          package = pkgs.rose-pine-icon-theme;
          name = "rose-pine";
        };
        cursor = {
          enable = true;
          name = "Simp1e-Dark";
        };
      };
      my.persist.home = {
        directories = [
          ".config/hypr"
        ];
      };
      programs.hyprland = {
        enable = true;
        package = hyprland-pkg;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };

      hj.files.".config/hypr/hyprland.conf".source = dots + "/hyprland-test.conf";
      hj.files.".config/hypr/move-focus.sh".source = dots + "/move-focus.sh";
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
