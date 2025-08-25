{...}: {
  imports = [
    ./greeters
    ./dbus.nix
    ./gnome-keyring.nix
    ./pipewire.nix
  ];
}
