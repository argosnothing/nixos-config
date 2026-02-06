# https://gitlab.com/Errium/nixorcism/-/blob/main/modules/packages/cli/fastfetch.nix?ref_type=heads#L25
{
  flake.modules.nixos.fetch = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [fastfetch];
    hj.files.".config/fastfetch/config.jsonc".text = builtins.toJSON {
      logo = {
        type = "data";
        source = ''
          $1          ▗▄▄▄       $2.*#&.    ,~=,
          $1          ▜███▙       $2&*+)^  %*^@*
          $1           ▜███▙       $2>=-@\/%*$)
          $1            ▜███▙       $2}(!-)$^]
          $1     ▟█████████████████▙ $2&(#@)/     $1▟▙
          $1    ▟███████████████████▙ $2$]<$\    $1▟██▙
          $2           ,___,           !)::&  $1▟███▛
          $2          [$*@#             %#!$ $1▟███▛
          $2         &*%!^               \/ $1▟███▛
          $2/)(*&!#$_#>)*                  $1▟██████████▙
          $2\!@#*@#%<>?&                  $1▟███████████▛
          $2      *}^#* $1▟▙               ▟███▛
          $2     &[!@) $1▟██▙             ▟███▛
          $2    /#$)$  $1▜███▙           ▝▀▀▀▀
          $2    <][(    $1▜███▙ $2%&!~)$&!_)$*!@#$(<>/
          $2     ^@     $1▟████▙ $2^?><!#$!(*&%!_%^)/
          $1           ▟██████▙       $2*(!)\
          $1          ▟███▛▜███▙       $2{>@%!
          $1         ▟███▛  ▜███▙       $2&^#$|
          $1         ▝▀▀▀    ▀▀▀▀▘       $2"*="
        '';
        position = "left";
      };

      display = {
        separator = "  ";
        bar = {
          width = 10;
          char = {
            elapsed = "■";
            total = "-";
          };
        };
        percent.type = ["num" "bar"];
      };

      modules = [
        {
          type = "title";
          format = "{user-name}@{host-name}";
        }
        {type = "separator";}

        {
          key = "OS  ";
          type = "os";
          format = "{pretty-name}";
        }
        {
          key = "KRNL";
          type = "kernel";
        }
        {
          key = "HOST";
          type = "host";
          format = "{family}";
        }
        {
          key = "PKGS";
          type = "packages";
        }

        "custom"

        {
          key = "DE  ";
          type = "de";
          format = "{pretty-name}";
        }
        {
          key = "WM  ";
          type = "wm";
          format = "{pretty-name}";
        }
        {
          key = "TERM";
          type = "terminal";
          format = "{pretty-name}";
        }
        {
          key = "SH  ";
          type = "shell";
        }

        "custom"

        {
          key = "CPU ";
          type = "cpu";
          format = "{name} @ {freq-max} - {temperature}";
          temp = true;
        }
        {
          key = "GPU ";
          type = "gpu";
          format = "{name} @ {frequency} - {core-usage-num}";
          driverSpecific = true;
        }
        {
          key = "RAM ";
          type = "memory";
          format = "{percentage-bar} {used} / {total} ({percentage})";
        }
        {
          key = "SWAP";
          type = "swap";
          format = "{percentage-bar} {used} / {total} ({percentage})";
        }

        "custom"

        {
          key = "UP  ";
          type = "uptime";
        }

        "custom"
        "colors"
      ];
    };
  };
}
