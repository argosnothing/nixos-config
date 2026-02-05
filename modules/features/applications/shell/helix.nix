{
  flake.modules.nixos.helix = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      helix
      nixd
      nil
      lldb
    ];
    hj.files = let
      dotsDir = config.impure-dir;
    in {
      ".config/helix/config.toml".source = dotsDir + "/helix/config.toml";
      ".config/helix/languages.toml".source = dotsDir + "/helix/languages.toml";
      ".config/helix/themes/noctalia.toml".source = dotsDir + "/helix/themes/noctalia.toml";
    };
  };
}
