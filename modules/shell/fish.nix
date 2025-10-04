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
    hjem.users.${settings.username} = {
      files = {
        ".config/fish/conf.d/show-base16.fish".text = ''
          function show-base16
                  for i in (seq 0 15)
                      set idx (printf "%X" $i)
                      set var base0$idx
                      set val (printenv $var)
                      if test -n "$val"
                          set r (math "0x"(string sub -s 2 -l 2 $val))
                          set g (math "0x"(string sub -s 4 -l 2 $val))
                          set b (math "0x"(string sub -s 6 -l 2 $val))
                          printf "%-6s %-9s \e[48;2;%d;%d;%dm  %-6s  \e[0m\n" \
                              $var $val $r $g $b " "
                      end
                  end
              end
        '';
      };
    };
  };
}
