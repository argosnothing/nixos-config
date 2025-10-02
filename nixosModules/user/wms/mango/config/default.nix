{config, ...}: let
  mango-settings = import ./settins {inherit config;};
in {
  imports = [
    ./waybar
    #./rofi
    #/scripts.nix
  ];
}
