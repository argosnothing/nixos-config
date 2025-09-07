{lib, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      disable_ligatures = "never";
      window_padding_width = 10;
    };
  };
}
