{settings, ...}:
{
  rebuild = "sudo nixos-rebuild switch --flake ${settings.flakedir}/#${settings.hostname}";
  secrets = "sops ${settings.flakedir}/secrets/secrets.yaml";
}
