{
  config,
  lib,
  pkgs,
  ...
}: {
  options.my.modules.gui.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Steam with gamescope support and gaming optimizations.";
  };

  config = lib.mkIf config.my.modules.gui.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    my.persist.home.directories = [
      ".local/share/Steam"
      ".steam"
      ".local/share/lutris"
    ];

    environment.systemPackages = with pkgs; [
      gamescope
      gamemode
      mangohud
      steam-run
      lutris
      bottles
      heroic
    ];

    programs.gamemode.enable = true;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true; # Required for 32-bit games
      };
    };

    boot.kernel.sysctl = {
      "fs.file-max" = 2097152;
      "vm.max_map_count" = 2147483642;
    };

    security.rtkit.enable = true;
  };
}
