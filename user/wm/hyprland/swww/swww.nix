{ pkgs, config, lib, ... }:
{
  home.packages = [ pkgs.swww ];

  # stable path pointing at Stylix’ current image (new store path each build)
  home.file.".local/share/wall/current".source = config.stylix.image;

  # re-apply wallpaper after each HM switch
  home.activation.swwwAfterSwitch = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.systemd}/bin/systemctl --user is-active --quiet swww-daemon || \
      ${pkgs.systemd}/bin/systemctl --user start swww-daemon

    ${pkgs.swww}/bin/swww query || ${pkgs.swww}/bin/swww init
    ${pkgs.swww}/bin/swww img "$HOME/.local/share/wall/current"
  '';

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "hyprland-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };
}
