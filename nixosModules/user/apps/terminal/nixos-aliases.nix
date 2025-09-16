{settings, ...}:
{
  #rebuilds = "sudo nixos-rebuild switch --flake ${settings.flakedir}/#${settings.hostname}";
  #rebuildb = "sudo nixos-rebuild boot --flake ${settings.flakedir}/#${settings.hostname}";
}
