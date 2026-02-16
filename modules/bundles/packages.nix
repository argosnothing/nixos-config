{inputs, ...}: {
  flake.modules.nixos.packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs;
      [
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
        ripgrep
        inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.ns
      ]
      ++ [inputs.noogle-search.packages.${pkgs.system}.default];
    my.persist.home.cache.directories = [
      ".cache/noogle-search"
    ];
  };
}
