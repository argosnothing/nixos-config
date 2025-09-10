{lib, ...}: {
  programs.kitty = {
    enable = true;
    keybindings = {
    };
    settings = {
      disable_ligatures = "never";
      window_padding_width = 10;
    };
  };
}
