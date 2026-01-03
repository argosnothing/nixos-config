{
  flake.modules.nixos.toys = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      pipes
      cbonsai
      cmatrix
      clock-rs
      aalib
      asciiquarium
      ninvaders
      nethack
      moon-buggy
      sl
      bb
      cowsay
    ];
  };
}
