{pkgs, ...}: {
  home.packages = with pkgs; [
    nemo
    nemo-fileroller
    loupe
  ];
}
