{inputs, ...}: {
  flake.modules.nixos.helix = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs;
      [
        nixd
        nil
        lldb
        gdb
        # helix
        bash-language-server
      ]
      ++ [inputs.helix.packages.${pkgs.system}.default];
    my.persist.home.directories = [".config/helix/themes"];

    hj.files = let
      dotsDir = config.impure-dir;
    in {
      ".config/helix/config.toml".source = dotsDir + "/helix/config.toml";
      ".config/helix/languages.toml".source = dotsDir + "/helix/languages.toml";
    };
  };
}
