# CREDITS: https://github.com/iynaix/dotfiles/blob/a494fec53ac1441ea78a9014564eb24f4724a285/modules/impermanence.nix#L126
# ( Although oh my lord did they make it hard to steal )
{ pkgs }:

pkgs.writeShellApplication {
  name = "show-tmpfs";
  runtimeInputs = [ pkgs.fd pkgs.coreutils pkgs.gawk pkgs.findutils pkgs.gnugrep ];
  text = ''
    sudo fd --one-file-system --base-directory / --type f --hidden \
      --exclude "/etc/{ssh,passwd,shadow}" \
      --exclude "*.timer" \
      --exclude "/var/lib/NetworkManager" \
      --exclude "/var/cache" \
      --exclude "/tmp" \
      --exclude "/nix/store" \
      --exclude "/proc" \
      --exclude "/sys" \
      --exclude "/dev" \
      --exclude "/run" \
      --exec ls -lS | sort -rn -k5 | awk '{print $5, $9}'
  '';
}
