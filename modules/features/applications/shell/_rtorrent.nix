{
  flake.modules.nixos.rtorrent = {
    hm = _: {
      programs.rtorrent = {
        enable = true;
      };
    };
  };
}
