{
  flake.modules.nixos.steam = {pkgs, ...}: {
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
        enable32Bit = true;
      };
    };

    boot.kernel.sysctl = {
      "fs.file-max" = 2097152;
      "vm.max_map_count" = 2147483642;
    };

    security.rtkit.enable = true;
  };
}
