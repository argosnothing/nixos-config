{
  flake.modules.nixos.base = {
    hm = {
      programs.fastfetch = {
        enable = true;
      };
    };
  };
}
