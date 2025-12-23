# citrix...
{...}: let
  pinnedNixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/29b6e7097f50955f49a81d2665fb21c94c43df19.tar.gz";
    sha256 = "0zrkfxj130gbgixgk8yaxk5d9s5ppj667x38n4vys4zxw5r60bjz";
  };
in {
  flake.overlays.citrix-pinned = final: prev: {
    inherit
      ((import pinnedNixpkgs {
        inherit (final) system;
        config =
          (prev.config or {})
          // {
            allowUnfree = true;
            allowInsecure = true;
            permittedInsecurePackages = ["libsoup-2.74.3"];
          };
      }))
      citrix_workspace
      ;
  };
}
