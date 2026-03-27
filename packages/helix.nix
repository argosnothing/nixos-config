# Wrapped helix-steel with declarative steel cogs and dev tools.
#
# Adding a new pure-scheme cog:
#   1. Add a fetchFromGitHub (or fetchFromGitea) with the repo, rev, and hash
#      - Use lib.fakeHash for hash, build to get the real one
#   2. Add ${installPureCog yourSrc} to the steelHome builder
#   3. Add a (require ...) line to .impure/helix/init.scm
#
# Adding a new native cog (has dylibs in cog.scm):
#   1. Fetch the source like above
#   2. Build the dylib with buildSteelDylib { pname, version, src, libName, cargoLock }
#      - libName is the [lib] name from the cog's Cargo.toml (e.g. "scooter_hx")
#      - Use cargoLock.lockFile for simple deps, cargoHash for complex git deps
#   3. Add ${installNativeCog yourSrc} to the steelHome builder
#   4. Add ln -sf ${yourDylib}/lib/lib<name>.so $out/native/ to steelHome
#   5. Add a (require ...) line to .impure/helix/init.scm
#
# Updating a cog:
#   1. Change the rev to the new commit hash
#   2. Set hash = lib.fakeHash, rebuild to get the new hash
#   3. For native cogs: if Cargo.lock changed, the cargoLock/cargoHash may also need updating
#      (same fakeHash trick)
{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    steel = inputs.steel.packages.${pkgs.system}.default;

    helix-base = inputs.helix-steel.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
      cargoBuildFlags = (oldAttrs.cargoBuildFlags or []) ++ ["--features" "steel,git"];
    });

    scooterSrc = pkgs.fetchFromGitHub {
      owner = "thomasschafer";
      repo = "scooter.hx";
      rev = "eaf2de26eed45e1405df72d22a6400709870802a";
      hash = "sha256-X2qlnNVN47Q1HEqiPC9vHZBsAcMCHsupO534XgDWZ9o=";
    };

    discordRpcSrc = pkgs.fetchFromGitHub {
      owner = "Ciflire";
      repo = "helix-discord-rpc";
      rev = "5b5f134c30c3a3d9a6f3565e8cc56973230bc7ef";
      hash = "sha256-L+fExKl4X1BHi+BIKHgBPtqyHHjqAc0qwyvCq8c0B0E=";
    };

    steelPtySrc = pkgs.fetchFromGitHub {
      owner = "mattwparas";
      repo = "steel-pty";
      rev = "4d41b6988107b50777d87e587fba7b6b272f069e";
      hash = "sha256-7teIMyLmfPkNEhTFlzmtKaewwwDrlcgmx06prUqXz1g=";
    };

    smoothScrollSrc = pkgs.fetchFromGitHub {
      owner = "thomasschafer";
      repo = "smooth-scroll.hx";
      rev = "1ed8b088e465fb139389c36ad158ba4a2d9e1bbc";
      hash = "sha256-4lxGZrT4cEcg3jqae3uJGGGCSy4WeVZeJ0hIApMb7jY=";
    };

    fakeWarpSrc = pkgs.fetchFromGitHub {
      owner = "Xerxes-2";
      repo = "fake-warp.hx";
      rev = "5b7947f3bb0dbc68dd0da82ab8aa3d1f19ee1164";
      hash = "sha256-W1kCvm3cj9NO0E5oGAe6mEUsVEu3NAcRbOQqehNNrFs=";
    };

    modelineSrc = pkgs.fetchFromGitea {
      domain = "codeberg.org";
      owner = "gwid";
      repo = "modeline.hx";
      rev = "71ced41de61af7fded1869c44b843499e1385340";
      hash = "sha256-9ZpGPXDe0Q/LmGq9WXRVVW5IOoe95obq/fG6TWige60=";
    };

    buildSteelDylib = {
      pname,
      version,
      src,
      libName,
      cargoLock ? null,
      cargoHash ? null,
    }:
      pkgs.rustPlatform.buildRustPackage ({
          inherit pname version src;
          doCheck = false;
          installPhase = ''
            runHook preInstall
            mkdir -p $out/lib
            find target -name "lib${libName}.so" -exec cp {} $out/lib/ \;
            runHook postInstall
          '';
        }
        // (
          if cargoLock != null
          then {inherit cargoLock;}
          else {inherit cargoHash;}
        ));

    scooterDylib = buildSteelDylib {
      pname = "scooter-hx";
      version = "0.1.4";
      src = scooterSrc;
      libName = "scooter_hx";
      cargoLock.lockFile = "${scooterSrc}/Cargo.lock";
    };

    discordRpcDylib = buildSteelDylib {
      pname = "helix-discord-rpc";
      version = "0.1";
      src = discordRpcSrc;
      libName = "helix_discord_rpc";
      cargoLock.lockFile = "${discordRpcSrc}/Cargo.lock";
    };

    weztermSrc = pkgs.fetchFromGitHub {
      owner = "mattwparas";
      repo = "wezterm";
      rev = "1bba5e2b90acb9efe864cb3e40aa6bce28da2687";
      hash = "sha256-xOQrR6c3kDuh0L+0EF3Q778UfndPyjNNFHZ3qFtQ3cY=";
    };

    finlUnicodeSrc = pkgs.fetchFromGitHub {
      owner = "wez";
      repo = "finl_unicode";
      rev = "a1892f26245529f2ef3877a9ebd610c96cec07a6";
      hash = "sha256-38S6XH4hldbkb6NP+s7lXa/NR49PI0w3KYqd+jPHND0=";
    };

    steelPtyDylib = let
      patched = pkgs.runCommand "steel-pty-src-patched" {} ''
        cp -r ${steelPtySrc} $out
        chmod -R u+w $out
        sed -i 's|wezterm-term = { git = "https://github.com/mattwparas/wezterm.git", branch = "mwp-public-scroll" }|wezterm-term = { path = "wezterm/term" }|g' $out/Cargo.toml
        sed -i 's|config = { git = "https://github.com/mattwparas/wezterm.git", branch = "mwp-public-scroll" }|config = { path = "wezterm/config" }|g' $out/Cargo.toml
        sed -i 's|git = "https://github.com/wez/finl_unicode.git", branch = "no_std"|path = "finl_unicode"|g' $out/Cargo.toml
        cp -r ${weztermSrc} $out/wezterm
        chmod -R u+w $out/wezterm
        cp -r ${finlUnicodeSrc} $out/finl_unicode
        sed -i 's|git="https://github.com/wez/finl_unicode.git", branch="no_std" ,|path = "../finl_unicode",|g' $out/wezterm/Cargo.toml
        sed -i '/^source = "git+https:\/\/github.com\/mattwparas\/wezterm/d' $out/Cargo.lock
        sed -i '/^source = "git+https:\/\/github.com\/wez\/finl_unicode/d' $out/Cargo.lock
      '';
    in
      pkgs.rustPlatform.buildRustPackage {
        pname = "steel-pty";
        version = "0.1.0";
        src = patched;
        cargoLock.lockFile = "${patched}/Cargo.lock";
        doCheck = false;
        installPhase = ''
          runHook preInstall
          mkdir -p $out/lib
          find target -name "libsteel_pty.so" -exec cp {} $out/lib/ \;
          runHook postInstall
        '';
      };

    installPureCog = src: ''
      cd ${src}
      STEEL_HOME=$out ${steel}/bin/forge install --force
    '';

    installNativeCog = src: ''
      tmpdir=$(mktemp -d)
      cp -r ${src}/* $tmpdir/
      chmod -R u+w $tmpdir
      cat ${src}/cog.scm | grep -v 'dylibs\|#:name' > $tmpdir/cog.scm
      cd $tmpdir
      STEEL_HOME=$out ${steel}/bin/forge install --force
      rm -rf $tmpdir
    '';

    steelHome =
      pkgs.runCommand "steel-home" {
        nativeBuildInputs = [steel];
      } ''
        mkdir -p $out/{cogs,native,bin,cached-modules,lsp,config}

        cp -r ${steel}/lib/steel/cogs/srfi $out/cogs/srfi
        cp -r ${steel}/lib/steel/cogs/steel $out/cogs/steel

        ${installPureCog smoothScrollSrc}
        ${installPureCog fakeWarpSrc}
        ${installPureCog modelineSrc}

        ${installNativeCog scooterSrc}
        ${installNativeCog discordRpcSrc}
        ${installNativeCog steelPtySrc}

        ln -sf ${scooterDylib}/lib/libscooter_hx.so $out/native/
        ln -sf ${discordRpcDylib}/lib/libhelix_discord_rpc.so $out/native/
        ln -sf ${steelPtyDylib}/lib/libsteel_pty.so $out/native/

        cp ${../. + "/.impure/helix/init.scm"} $out/config/init.scm
        cp ${../. + "/.impure/helix/helix.scm"} $out/config/helix.scm
        cp ${../. + "/.impure/helix/config.toml"} $out/config/config.toml
        cp ${../. + "/.impure/helix/languages.toml"} $out/config/languages.toml
      '';

    nnd-launch = pkgs.writeShellScriptBin "nnd-launch" ''
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
    '';

    hxWrapper = pkgs.writeShellScript "hx-wrapper" ''
      STEEL_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}/steel"
      rm -rf "$STEEL_HOME/cogs" "$STEEL_HOME/native" "$STEEL_HOME/bin"
      mkdir -p "$STEEL_HOME"/{cogs,cached-modules}
      ln -sfn "${steelHome}/native" "$STEEL_HOME/native"
      ln -sfn "${steelHome}/bin" "$STEEL_HOME/bin"
      for cog in "${steelHome}"/cogs/*/; do
        name=$(basename "$cog")
        ln -sfn "$cog" "$STEEL_HOME/cogs/$name"
      done
      export STEEL_HOME
      HELIX_CONFIG="''${XDG_CONFIG_HOME:-$HOME/.config}/helix"
      mkdir -p "$HELIX_CONFIG"
      for f in init.scm helix.scm config.toml languages.toml; do
        [ ! -e "$HELIX_CONFIG/$f" ] && ln -sfn "${steelHome}/config/$f" "$HELIX_CONFIG/$f"
      done
      exec ${helix-base}/bin/hx "$@"
    '';

    extraBinPath = with pkgs; [
      nixd
      nil
      lldb
      nnd
      gdb
      bash-language-server
      steel
      nnd-launch
    ];
  in {
    packages.helix = pkgs.symlinkJoin {
      name = "helix";
      paths = [helix-base nnd-launch pkgs.nnd];
      nativeBuildInputs = [pkgs.makeWrapper];
      meta.mainProgram = "hx";
      postBuild = ''
        rm $out/bin/hx
        makeWrapper ${hxWrapper} $out/bin/hx \
          --prefix PATH : ${pkgs.lib.makeBinPath extraBinPath}
      '';
    };
  };
}
