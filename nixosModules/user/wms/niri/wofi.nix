{...}: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 600;
      height = 400;
      location = "center";
      matching = "fuzzy";
      insensitive = true;
      parse_search = true;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      normal_window = true;
      layer = "overlay";
      term = "kitty";
      columns = 2;
    };
  };
}
