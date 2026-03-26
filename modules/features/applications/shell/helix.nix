# Steel forge plugins (e.g. scooter, presence):
# `forge pkg install --git` is BROKEN — return! in maybe-git-clone escapes the
# entire threading pipeline, returning a raw path string instead of a parsed cog hash.
# Instead, clone/cd into the package dir and run:
#   nix-shell -p cargo rustc gcc pkg-config --run "cd <pkg-dir> && forge install --force"
# cargo is needed because forge compiles native dylibs.
{inputs, ...}: {
  flake.modules.nixos.helix = {
    pkgs,
    lib,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs;
      [
        nixd
        nil
        lldb
        nnd
        gdb
        bash-language-server
        (writeShellScriptBin "nnd-launch" ''
          bp_args=()
          if [ -f /tmp/nnd-bp ]; then
            bp=$(cat /tmp/nnd-bp)
            [ -n "$bp" ] && bp_args=(--breakpoint "$bp")
            rm -f /tmp/nnd-bp
          fi

          dir="$PWD"
          while [ "$dir" != "/" ]; do
            [ -f "$dir/Cargo.toml" ] && break
            dir="$(dirname "$dir")"
          done

          if [ ! -f "$dir/Cargo.toml" ]; then
            echo "No Cargo.toml found"
            read -r -p "Press enter to close"
            exit 1
          fi

          name=$(${lib.getExe pkgs.gnused} -n '/^\[package\]/,/^\[/{s/^name *= *"\(.*\)"/\1/p}' "$dir/Cargo.toml")
          if [ -z "$name" ]; then
            echo "Could not determine binary name from Cargo.toml"
            read -r -p "Press enter to close"
            exit 1
          fi

          binary="$dir/target/debug/$name"
          echo "Binary: $binary"
          [ ''${#bp_args[@]} -gt 0 ] && echo "Breakpoint: ''${bp_args[*]}"
          read -r -p "Args: " args
          exec nnd "''${bp_args[@]}" "$binary" $args
        '')
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
