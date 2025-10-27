{
  flake.modules.nixos.niri = {lib, ...}: let
    inherit (lib) mkAfter;
  in {
    my.sessions = mkAfter [
      {
        manage = "window";
        name = "niri";
        start = "niri-session";
      }
    ];
  };
}
