{...}: {
  imports = [
    ./greeters
    ./dbus.nix
    ./gnome-keyring.nix
    ./pipewire.nix
  ];
  services.mullvad-vpn.enable = true;
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    dnsovertls = "true";
  };
}
