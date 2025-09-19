{pkgs, ...}: {
  imports = [
    ../home.nix
  ];

  home.packages = with pkgs; [
    pkgs.noto-fonts-monochrome-emoji
    prismlauncher
    r2modman
  ];

  zed.enable = true;
}
