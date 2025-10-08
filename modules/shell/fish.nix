{
  pkgs,
  config,
  settings,
  lib,
  ...
}: {
  options.my.modules.shell.fish = {
    enable = lib.mkEnableOption "FIIIISH";
  };
  config = lib.mkIf config.my.modules.shell.fish.enable {
    programs.fish = {
      enable = true;
    };
    hm = _: {
      my.persist.home.cache.directories = [
        ".cache/fish"
      ];
    };
    hjem.users.${settings.username} = {
      files = {
        ".config/fish/conf.d/show-base16.fish".text = ''
                    function show-base16
            for i in (seq 0 15)
                set idx (string upper (printf "%02x" $i))
                set var base$idx
                set val (printenv $var)
                test -n "$val" || continue

                set hex (string replace -r '^#' \'\' -- $val)
                set r (math 0x(string sub -s 1 -l 2 -- $hex))
                set g (math 0x(string sub -s 3 -l 2 -- $hex))
                set b (math 0x(string sub -s 5 -l 2 -- $hex))

                printf "%-6s %-6s \e[48;2;%d;%d;%dm  \e[0m\n" $var $val $r $g $b
            end
          end
        '';
      };
    };
  };
}
