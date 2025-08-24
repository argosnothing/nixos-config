{pkgs, inputs, ...}: let
in {
  imports = [
    ../services/dbus.nix
    ../services/gnome-keyring.nix
    ../services/pipewire.nix
  ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    papirus-icon-theme
    hicolor-icon-theme
    gtk3
    gtk4
    glib
    gsettings-desktop-schemas
    # Icon fonts
    font-awesome
    material-design-icons
  ];

  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.excludePackages = [pkgs.xterm];

  # Ensure GTK cache is built
  programs.dconf.enable = true;
  services.dbus.enable = true;
}
