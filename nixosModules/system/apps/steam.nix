{ config, lib, pkgs, ... }:

{
  options.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable Steam with gamescope support and gaming optimizations.";
  };

  config = lib.mkIf config.steam.enable {
    # Enable Steam and gamescope
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports for Steam Local Network Game Transfers
      
      # Enable gamescope session
      gamescopeSession.enable = true;
      
      # Extra compatibility tools (Proton-GE, etc.)
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    custom.persist.home.directories = [
      ".local/share/Steam"
      ".steam/steam"
      ".local/share/lutris"
    ];

    # Gaming-related system packages
    environment.systemPackages = with pkgs; [
      gamescope # Steam's microcompositor for gaming
      gamemode # Optimize system performance for games
      mangohud # Gaming performance overlay
      steam-run # Run non-Steam games with Steam runtime
      lutris # Game launcher with Wine support
      bottles # Wine prefix manager
      heroic # Epic Games Store launcher
    ];

    # Enable GameMode for system-level game optimizations
    programs.gamemode.enable = true;

    # Hardware acceleration and gaming optimizations
    hardware = {
      # Enable OpenGL and hardware acceleration
      graphics = {
        enable = true;
        enable32Bit = true; # Required for 32-bit games
      };
    };

    # Gaming-related system tweaks
    boot.kernel.sysctl = {
      # Increase file descriptor limits for games
      "fs.file-max" = 2097152;
      # Increase memory map count for games like CS2, Apex Legends
      "vm.max_map_count" = 2147483642;
    };

    # Enable realtime scheduling for better gaming performance
    security.rtkit.enable = true;
  };
}
