{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    clang
    clang-tools
    lldb
    gdb
    pkg-config
    meson
    ninja
  ];
  buildInputs = with pkgs; [
    libinput
    pixman
    xorg.libX11
    wayland
    wayland-protocols
    wayland-scanner
    wlroots_0_18
    wlroots_0_17
    wlroots_0_19
    libxkbcommon
  ];
  packages = with pkgs; [
  ];
}
