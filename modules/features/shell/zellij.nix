{
  flake.modules.nixos.zellij = {
    my.persist.home = {
      directories = [
        ".config/zellij"
      ];
      cache.directories = [
        ".cache/zellij"
      ];
    };
    hm = {
      home.shell.enableFishIntegration = true;
      programs.zellij = {
        enable = true;
        attachExistingSession = true;
        enableFishIntegration = true;
        exitShellOnExit = true;
      };
    };
  };
}
