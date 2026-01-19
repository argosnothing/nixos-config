### Quantum is persistence, but for things I want to sync across machines
### Only meant for certain folders I know won't contain secrets
{
  flake.modules.nixos.quantum = {
    pkgs,
    lib,
    config,
    ...
  }: let
    user = config.my.username;
    home = "/home/${user}";

    repo = "${home}/nixos-config";
    quantumRoot = "${repo}/.quantum";

    dirs = config.my.quantum.directories or [];
    files = config.my.quantum.files or [];

    mkMount = rel: {
      what = "${quantumRoot}/${rel}";
      where = "${home}/${rel}";
      type = "none";
      options = "bind,nofail";
      wantedBy = ["local-fs.target"];
    };

    mkDirRule = rel: "d ${home}/${rel} 0755 ${user} users - -";

    mkFileRule = rel: "f ${home}/${rel} 0644 ${user} users - -";

    parentDir = p: let
      m = builtins.match "(.+)/[^/]+$" p;
    in
      if m == null
      then "."
      else builtins.elemAt m 0;

    mkParentRule = rel: let
      pd = parentDir rel;
    in
      if pd == "."
      then null
      else "d ${home}/${pd} 0755 ${user} users - -";
  in {
    config = {
      systemd.tmpfiles.rules =
        (builtins.filter (x: x != null) (map mkParentRule files))
        ++ (map mkDirRule dirs)
        ++ (map mkFileRule files);

      systemd.mounts =
        (map mkMount dirs)
        ++ (map mkMount files);
    };
  };
}
