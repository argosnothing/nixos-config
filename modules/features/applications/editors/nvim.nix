{inputs, ...}: {
  flake.modules.nixos.nvim = {pkgs, ...}: {
    my.persist.home.directories = [
      ".local/state/mnw"
      ".local/share/mnw"
      ".cache/mnw"
    ];
    environment.systemPackages = with pkgs; [
      fd
    ];

    hj.packages = [inputs.nvim-nix.packages.${pkgs.system}.default];
  };
}
