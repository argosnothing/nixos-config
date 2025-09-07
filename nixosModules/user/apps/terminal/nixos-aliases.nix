{settings, ...}:
{
  updatesystem = "sudo nixos-rebuild switch --flake ${settings.flakedir}/#${settings.hostname}";
  updatehome = "home-manager switch --flake ${settings.flakedir}/#${settings.username}@${settings.hostname}";
  nvf = "nix run ${settings.flakedir}#nvf";
}