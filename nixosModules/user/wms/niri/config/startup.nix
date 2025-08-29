{ ... }:

{
  programs.niri.settings.spawn-at-startup = [
    {command = ["xwayland-satellite"];}
    {command = ["swww-daemon"];}
    {command = ["noctalia-shell"];}
    {command = ["discord"];}
  ];
}
