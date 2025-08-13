{pkgs, ...}: {
  #fonts.packages = with pkgs.nerd-fonts; [jetbrains-mono];
  stylix.targets.waybar.enable = true;
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = {
      mainBar = {
        position = "bottom";
        modules-left = [ "hyprland/workspaces" ];
        "hyprland/workspaces" = { };
      };
    };
  };
}
