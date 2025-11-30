{
  flake.modules.nixos.base = {pkgs, ...}: {
    enviornment.systemPackages = with pkgs; [
      jq
      wev
      fzf
      ytfzf
      desktop-file-utils
      nix-direnv
      direnv
      bolt-launcher
      mpv
      bash
      vulkan-tools
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.ns
    ];
  };
}
