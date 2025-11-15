{
  inputs,
  ...
}: {
  flake.lib.mk-pkgs-stable = pkgs:
    import inputs.nixpkgs-stable {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
        allowAliases = true;
        permittedInsecurePackages = ["libsoup-2.74.3" "libxml2-2.13.8"];
      };
    };
}
