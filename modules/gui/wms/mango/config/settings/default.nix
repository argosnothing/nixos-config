{
  config,
  lib,
  ...
}: let
  binds = import ./binds.nix;
  monitors = import ./monitors.nix {inherit config lib;};
  mango-inputs = import ./inputs.nix;
  layouts = import ./layouts.nix;
  overview = import ./overview.nix;
  scratchpads = import ./scratchpads.nix;
  styling = import ./styling.nix {inherit config;};
  tags = import ./tags.nix;
  misc = import ./misc.nix;
in
  binds
  + monitors
  + mango-inputs
  + layouts
  + overview
  + scratchpads
  + styling
  + tags
  + misc
