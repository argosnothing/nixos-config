{inputs, ...}: {
  flake.modules.nixos.packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      jq
      wev
      wget
      fzf
      ytfzf
      desktop-file-utils
      nix-direnv
      direnv
      mpv
      bash
      tree
      vulkan-tools
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.ns
    ];
  };
}
