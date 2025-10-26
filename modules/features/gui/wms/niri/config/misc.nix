{
  flake.modules.nixos.niri = {
    hm.programs.niri.settings = {
      prefer-no-csd = true;
    };
  };
}
