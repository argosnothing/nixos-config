{
  flake.modules.nixos.emacs = {pkgs, ...}: {
    services.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;
    };
  };
}
