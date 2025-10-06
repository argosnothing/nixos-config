{...}: {
  imports = [
    ./virtualization
    ./wms

    ./firefox.nix
    ./librewolf.nix
    ./chrome.nix

    ./flatpak.nix
    ./steam.nix
    ./via.nix
    ./discord.nix
    ./nemo.nix
  ];
}
