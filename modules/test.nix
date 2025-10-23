{lib, ...}: {
  options.beans = {
    enable = lib.mkEnableOption "ok";
  };
}
