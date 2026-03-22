{inputs, ...}: {
  flake.modules.nixos.nvim = {pkgs, ...}: {
    my.persist.home.directories = [
      ".local/state/mnw"
      ".local/share/mnw"
    ];

    hj.packages = [inputs.nvim-nix.packages.${pkgs.system}.default];
  };
}
