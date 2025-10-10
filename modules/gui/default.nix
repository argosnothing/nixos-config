{...}: {
  imports = [
    ./wms
    ./desktop-shells

    ./firefox.nix
    ./librewolf.nix
    ./chrome.nix

    ./virtualization

    ./flatpak.nix
    ./steam.nix
    ./via.nix
    ./discord.nix
    ./nemo.nix
  ];
}
