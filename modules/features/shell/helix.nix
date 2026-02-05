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
      ".config/helix/config.toml" = dotsDir + "/helix/config.toml";
      ".config/helix/languages.toml" = dotsDir + "/helix/languages.toml";
      ".config/helix/themes/noctalia.toml" = dotsDir + "/helix/themes/noctalia.toml";
    };
  };
}
