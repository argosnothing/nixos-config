# Options

### fonts.nix

- The interface for setting fonts on my system: `modules.nixos.options`

### monitors.nix

- The interface for setting monitor positions: `modules.nixos.options`

### options.nix

- Mostly persist options that get used when impermanence is enabled:
  `modules.nixos.options`

### sessions.nix

- Options that describe session information. Currently unused.
  `modules.nixos.options`

### settings.nix

- Flake-level options, most aren't really needed at this level and
  cannot be set within a host. `-`

### style.nix

- The interface for setting and configuring themes for my system.
  Currently stylix uses these options. `modules.nixos.options`
