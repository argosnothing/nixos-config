_: {
  hm = {self, ...}: {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "${self}/media/icons/crescent.svg";
        };
      };
    };
  };
}
