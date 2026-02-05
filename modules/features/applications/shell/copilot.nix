{
  flake.modules.nixos.copilot-cli = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [github-copilot-cli];
    my.persist = {
      home.directories = [
        ".copilot"
        ".config/configstore"
        ".config/github-copilot"
        ".config/copilot-chat"
      ];
      home.cache.directories = [
        ".cache/copilot-chat"
      ];
    };
  };
}
