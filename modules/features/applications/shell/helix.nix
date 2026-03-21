# Steel forge plugins (e.g. scooter, presence):
# `forge pkg install --git` is BROKEN — return! in maybe-git-clone escapes the
# entire threading pipeline, returning a raw path string instead of a parsed cog hash.
# Instead, clone/cd into the package dir and run:
#   nix-shell -p cargo rustc gcc pkg-config --run "cd <pkg-dir> && forge install --force"
# cargo is needed because forge compiles native dylibs.
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
        bash-language-server
      ]
      # ++ [inputs.helix.packages.${pkgs.system}.default];
      ++ [
        (inputs.helix-steel.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
          cargoBuildFlags = (oldAttrs.cargoBuildFlags or []) ++ ["--features" "steel,git"];
        }))
        (inputs.steel.packages.${pkgs.system}.default)
      ];
    my.persist.home.directories = [
      ".config/helix/themes"
      ".local/share/steel"
    ];

    hj.files = let
      dotsDir = config.impure-dir;
    in {
      ".config/helix/config.toml".source = dotsDir + "/helix/config.toml";
      ".config/helix/languages.toml".source = dotsDir + "/helix/languages.toml";
      ".config/helix/helix.scm".source = dotsDir + "/helix/helix.scm";
      ".config/helix/init.scm".source = dotsDir + "/helix/init.scm";
      ".config/helix/cogs".source = dotsDir + "/helix/cogs";
    };
  };
}
