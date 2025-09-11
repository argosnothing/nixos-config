{settings, ...}:
{
  rebuild = "sudo nixos-rebuild switch --flake ${settings.flakedir}/#${settings.hostname}";
}
