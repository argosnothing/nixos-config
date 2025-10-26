{
  flake.modules.nixos.chrome = {
    hm = {
      programs.google-chrome.enable = true;
    };
  };
}
