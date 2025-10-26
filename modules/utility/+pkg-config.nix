{
  flake.lib.pkg-config = {
    allowUnfree = true;
    allowAliases = true;
    permittedInsecurePackages = ["libsoup-2.74.3" "libxml2-2.13.8"];
  };
}
