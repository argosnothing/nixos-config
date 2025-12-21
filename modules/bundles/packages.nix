{inputs, ...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    my.persist.home.directories = [
      ".local/share/bolt-launcher"
    ];
    environment.systemPackages = with pkgs; [
      plan9port
      jq
      wev
      wget
      fzf
      ytfzf
      desktop-file-utils
      nix-direnv
      direnv
      bolt-launcher
      mpv
      bash
      tree
      vulkan-tools
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.ns
    ];
  };
}
