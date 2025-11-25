## I completely ripped and pasta'd this from jet's repo!
## I am a thief! A thief!!!!!
## https://github.com/Michael-C-Buckley/nixos/blob/master/modules/packages/vscode.nix
{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    pkgs' = import inputs.nixpkgs {
      localSystem = pkgs.stdenv.hostPlatform;
      config.allowUnfree = true;
    };
    wrappedInputs = with pkgs'; [
      neovim
      python313
      uv
      nil
      nixd
      sops
      alejandra
      go
      gopls
      delve
      go-tools
      golangci-lint
    ];
  in {
    packages.vscode = pkgs.symlinkJoin {
      name = "code";
      paths = [pkgs'.vscode];
      buildInputs = wrappedInputs;
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/code \
        --prefix PATH : ${pkgs.lib.makeBinPath wrappedInputs}
      '';
    };
  };
}
