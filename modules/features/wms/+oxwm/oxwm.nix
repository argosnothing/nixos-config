{
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.oxwm = {
    pkgs,
    config,
    lib,
    ...
  }: let
    nixos-modules = with flake.modules.nixos; [
      ly
      icons
      gtk
    ];
    monitor = builtins.head config.my.monitors;
    refreshStr = toString (builtins.floor monitor.refresh);
    xrandrCmd = "${pkgs.xorg.xrandr}/bin/xrandr --output ${monitor.name} --mode ${toString monitor.dimensions.width}x${toString monitor.dimensions.height} --rate ${refreshStr}";
    picomConf = pkgs.writeText "picom.conf" ''
      backend = "glx";
      blur-background = true;
      blur-method = "dual_kawase";
      blur-strength = 5;
      inactive-opacity = 0.93;
      active-opacity = 0.93;
      frame-opacity = 0.93;
      opacity-rule = [
        "100:class_g = 'looking-glass-client'",
        "100:class_g = 'mpv'",
        "100:class_g = 'maim'",
        "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      ];
      blur-background-exclude = [
        "class_g = 'looking-glass-client'",
        "class_g = 'maim'",
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      ];
      vsync = true;
      fading = true;
      fade-in-step = 0.05;
      fade-out-step = 0.05;
      shadow = true;
      shadow-radius = 12;
      shadow-opacity = 0.75;
      shadow-exclude = [
        "name = 'Notification'",
        "_GTK_FRAME_EXTENTS@:c"
      ];
    '';
  in {
    environment.systemPackages = with pkgs; [
      dmenu
      oxwm
      maim
      ksnip
      xclip
      nitrogen
      picom-pijulius
    ];
    imports = nixos-modules;
    services.xserver = {
      enable = true;
      windowManager.oxwm = {
        enable = true;
        package = inputs.oxwm.packages.${pkgs.system}.default;
      };
      displayManager.sessionCommands = ''
        ${xrandrCmd}
        ${pkgs.picom-pijulius}/bin/picom --config ${picomConf} --daemon &
        ${pkgs.nitrogen}/bin/nitrogen --restore &
      '';
    };
    my.cursor = {
      enable = true;
      name = "Simp1e-Dark";
    };
    my.persist.home.directories = [".config/oxwm" ".config/nitrogen"];
  };
}
